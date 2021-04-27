# a family member has 2 attributes:
# full name, e.g.: "James Andrew Warren Ogryzek"
# preferred name, e.g.: "Drew"
# How should we represent a single family member?
# 
# member = ["full name", "preferred name"]
#
# members = [member1, member2, member3], etc...
#
# members = [
#     ["full name 1", "preferred name 1"], 
#     ["full name 2", "preferred name 2"]
# ]
#

family_members = []
# How are we going to collect information about family members?
#
# For each family member, we need to collect 2 values:
#  - full name
#  - preferred name
#
# And we want to store each member in the list of family members
#
# Let's prompt a user to enter a family member or quit

# puts "Press 'e' to enter a family member, or press 'q' to quit:"

# while true do
#     user_input = gets.chomp
#     if user_input == 'q'
#         break
#     elsif user_input == 'e'
#         puts "Enter family member's full name:"
#         full_name = gets.chomp
#         puts "Enter family member's preferred name:"
#         preferred_name = gets.chomp
#         puts "Entered: Full Name: #{full_name}, Preferred Name: #{preferred_name}"
#         puts "Press 'e' to enter another family member, or press 'q' to quit:"
#         user_input = gets.chomp
#         if user_input == 'e'
#             next
#         else
#             break
#         end
#     end
# end

puts "How many family members do you have?"
family_member_count = gets.to_i
family_members = []

while family_member_count > 0 do
    family_member_count -= 1
    puts "Enter family member's full name:"
    full_name = gets.chomp
    puts "Enter family member's preferred name:"
    preferred_name = gets.chomp
    # family_member = "Full Name: #{full_name}, Preferred Name: #{preferred_name}"
    family_member = [full_name, preferred_name]
    family_members.push(family_member)
end

# puts family_members
family_members.each do |member|
    puts "Full Name: #{member[0]}, Preferred Name: #{member[1]}"
end