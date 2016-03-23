s/\(.*\)/: {root: \['\1\']},/g
s/\//','/g
s/-\([a-zA-Z]\)/\U\1/g
s/'\([^']\)\([^']*Exception']},\)$/'\U\1\E\2/
s/'components','input','\([^']\)\([^']*\)']},$/'components','input','\U\1\E\2']},/
s/'components','\([^']\)\([^']*\)']},$/'components','\U\1\E\2']},/
s/'components','Input']},$/'components','input']},/
s/'components','input','checkbox','withError']},/'components','input','CheckboxWithError']},/
