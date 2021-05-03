# 
#
# `Hello => "H, l, l, [e, o]"`
#
# use: `letters = "b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, z, [a, e, i, o, u, y]"`


def write(word)
    File.open('words', 'a') do |file|
        file.write("#{word}\n")
    end
end

def save(word)
    word_to_write = word
    letters = "b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, z, [a, e, i, o, u, y]"
    consonants, vowels = letters.split(", [")
    vowels.replace vowels[0..-2]

    first_part = ''
    second_part = ''

    word.split('').each do |letter|
        is_consonant = consonants.count(letter) > 0
        is_vowel = vowels.count(letter) > 0
        if is_consonant 
            first_part += letter
        elsif is_vowel
            second_part += letter
        else
            raise "I don't know what to do here!"
        end
    end
    fp = first_part.split('').join(', ')
    sp = second_part.split('').join(', ')
 

    word_to_write = "#{fp}, [#{sp}]"

    write word_to_write
end

save "hello"
