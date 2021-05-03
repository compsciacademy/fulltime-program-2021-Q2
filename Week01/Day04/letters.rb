letters = "b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, z, [a, e, i, o, u, y]"

consonants, vowels = letters.split(", [")

puts consonants
puts vowels[-1] # how can we remove the last item from a string?
                # alternatively, how can we remove a character from a string, in this case "]"?
                # vowels.chomp(']')
                # vowels.replace vowels[0..-2]
                # vowels.tr("]", "")

# Exercise 01

