#!/usr/bin/env bash
# Thanks for: https://gist.github.com/evelyne24/7714094

# Notes
# In MacOS, + does not work for regex, nor -E flag.
# Instead I used \{1,\} for char repetition.
[[ -f /usr/bin/mvn ]] || { return ; }


# Formatting constants
bold=`tput bold`
red=`tput setaf 1`
bg_red=`tput setab 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
grey=`tput setaf 7`
white=`tput sgr0`
end=`tput sgr0`

info=${white}
debug=${grey}
success=${green}
warn=${yellow}
error=${bold}${red}
skipped=${grey}
downloading=${cyan}
projdash=${cyan}
projname=${bold}${cyan}
plugdash=${blue}
plugname=${bold}${blue}

# Wrapper function for Maven's mvn command.
mvn-color()
{
  # Filter mvn output using sed
  /usr/bin/mvn $@ | sed -e "s/\(\[INFO\]\) Building \(.*\)/${info}\1${end} ${projname}Building \2${end}/g" \
           -e "s/\(\[INFO\]\) \(\-\{1,\}\) \(.*\) \(\-\{1,\}\)/${info}\1${end} ${plugdash}\2${end} ${plugname}\3${end} ${plugdash}\4${end}/g" \
           -e "s/\(\[INFO\]\) \(\-*\)/${info}\1${end} ${projdash}\2${end}/g" \
         -e "s/\(\[DEBUG\].*\)/${debug}\1${end}/g" \
         -e "s/\(\[WARNING\].*\)/${warn}\1${end}/g" \
         -e "s/\(unsafe operations\)/${warn}\1${end}/g" \
         -e "s/\(deprecated API\)/${warn}\1${end}/g" \
         -e "s/\(SUCCESS\) \[/${success}\1${end} [/g" \
         -e "s/\(FAILURE\) \[/${error}\1${end} [/g" \
         -e "s/\(\[ERROR\].*\)/${error}\1${end}/g" \
         -e "s/SUCCESS \(\[[0-9]*.[0-9]*s\]\)/${success}SUCCESS \1${end}/g" \
         -e "s/FAILURE \(\[[0-9]*.[0-9]*s\]\)/${error}FAILURE \1${end}/g" \
         -e "s/SKIPPED/${skipped}SKIPPED${end}/g" \
         -e "s/BUILD FAILURE/${error}BUILD FAILURE${end}/g" \
         -e "s/BUILD SUCCESS/${success}BUILD SUCCESS${end}/g" \
         -e "s/\(<<< FAILURE!\)/${error}\1${end}/g" \
         -e "s/\(<<< ERROR!\)/${error}\1${end}/g" \
         -e "s/Caused by: \(.*\)/${white}${bg_red}Caused by: \1${end}/g" \
         -e "s/Tests run: \([0-9]*\), Failures: \([0-9]*\), Errors: \([0-9]*\), Skipped: \([0-9]*\)/${success}Tests run: \1 ${end}, ${warn}Failures: \2 ${end}, ${error}Errors: \3 ${end}, ${skipped}Skipped: \4 ${end}/g"

  # Make sure formatting is reset
  echo -ne ${end}
}

# Override the mvn command with the colorized one.
alias mvn="mvn-color"