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

#TODO add ability to select directory
case $subcommand in
    new) 
        filename="$2"
        if [ -z "$filename" ]; then
            echo "Enter New Filename"
            read filename
        fi
        "$EDITOR" "$directory/$filename"
        ;;
    *)
        main "$1"
esac

