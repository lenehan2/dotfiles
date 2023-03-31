#!/usr/bin/env zsh
set -e

directory=$(eval echo "$NOTESDIRECTORY")

main() {
  previous_file="$1"
  selected_query=`select_file $previous_file`
  file_to_edit=`parse_file $selected_query`
  raw_query=`echo $selected_query | cut -d ':' -f 3`

  if [ -n "$file_to_edit" ] ; then
    "$EDITOR" "$directory/$file_to_edit"
    main "$raw_query"
  fi
}

select_file() {
  given_file="$1"
  parsed_filename=`parse_file $given_file`
  echo $(cd $directory && ag "[^\r\n]" . --ignore fuz.sh | fzf --preview="echo {} | cut -d ':' -f 1 | xargs cat" --preview-window=right:68%:wrap --query="$parsed_filename") 
}

parse_file() {
  echo $1 | cut -d ':' -f 1
}

subcommand="$1"
filename="$2"

if [ -n "$subcommand" ]; then
    shift
    if [ -n "$filename" ]; then
        shift
    fi
fi

#TODO add ability to select directory
case $subcommand in
    usage) 
        echo "notes [new|label|term]"
        ;;
    help) 
        echo "notes [new|label|term]"
        ;;
    new) 
        if [ -z "$filename" ]; then
            echo "Enter New Filename"
            read filename
        fi
        "$EDITOR" "$directory/$filename"
        ;;
    label)
        if [ -z "$filename" ]; then
            echo "Enter New Filename"
            read filename
        fi
        if (( $# < 1 )); then
            echo "Enter Labels"
            read labels
        else
            labels="$@"
        fi 
	if grep -xq "BEGIN_NOTES_LABELS" "$filename"; then 
            line=$(sed -n -e '/BEGIN_NOTES_LABELS/,/END_NOTES_LABELS/ p' "$filename" | sed '1d;$d') 
            newline="$line, $labels"
            sed -i '' "s/$line/$newline/g" "$filename"
	else
            echo "\`\`\`\nBEGIN_NOTES_LABELS" >> "$filename"
            echo "$labels" >> "$filename"
            echo "END_NOTES_LABELS\n\`\`\`" >> "$filename"
	fi
        ;;
    *)
        main "$subcommand"
esac

