" from http://vi.stackexchange.com/a/2848/7702
function! SentencePerLine(start, end)
    silent execute a:start.','.a:end.'s/[.!?]\zs /\r/g'
endfunction
