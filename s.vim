vim9script
set nocompatible
set verbose=1

const PATTERNS = [
    '^[-A-Z .][-A-Z0-9 .()_]*\ze\(\s\+\*\|$\)',          # current version in Vim
    '^[A-Z.][-A-Z0-9 .,()_?]*\ze\(\s\+\*\|$\)',          # my original proposal
    '^ *[-A-Z.][-A-Z0-9 .()_]*?\=\ze\(\s\+\*\|$\)',      # Bram's counter-proposal
    '^[ \t]*[A-Z.][-A-Z0-9 .,()_]*?\=\ze\(\s\+\*\|$\)',  # my modification of the above
    '^[A-Z.][-A-Z0-9 .,()_]*?\=\ze\(\s\+\*\|$\)',        # my latest proposal
    ]
const helpHeadline = PATTERNS[str2nr($PATTERN)]

cd /usr/share/vim/vim90/doc
for fname in readdir(".", (n) => n =~ '.txt$')
    echo fname .. ":"
    var lineno = 1
    for line in readfile(fname)
        const e = matchend(line, helpHeadline)
        if e != -1
            echo printf(" %5d: [%s|%s]", lineno, line[ : e - 1], line[e : ])
        endif
        ++lineno
    endfor
endfor

echo ""
q
