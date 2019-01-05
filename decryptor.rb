#!/usr/bin/env ruby
=begin
Labyrinth Copyright (C) 2018 Grathium Sofwares <grathiumsoftwears@gmail.com>
This program comes with ABSOLUTELY NO WARRANTY
This is a free software, and you are welcome to redistribute it under certain
conditions.
=end

class Encryptor
	$end_file=''

	def cipher(rotation)
		characters = (' '..'z').to_a
		offset_characters = characters.rotate(rotation)
		pairs = characters.zip(offset_characters)
		Hash[pairs]

	end

	def encrypt_letter(letter,rotation)
		cipher_for_rotation = cipher(rotation)
		cipher_for_rotation[letter]
	end

	def encrypt(string,rotation)
		letters = string.split('')

		results = letters.collect do |letter|
			encrypted_letter = encrypt_letter(letter, rotation)
		end
			
		results.join

	end

	def decrypt(string, rotation)
		rotation = -(rotation)
		letters = string.split('')

		results = letters.collect do |letter|
			encrypted_letter = encrypt_letter(letter, rotation)
		end

		results.join
		results = results.to_s
		results.delete! '[]""'
		results.gsub! 'nil', ''
		return results
	end

  def decrypt_file(filename, rotation)
  
    # Create the file handle to the encrypted file
    message = File.open(filename, "r")
    # Read the encrypted text
    read_message = message.read
    # Decrypt the text by passing in the text and rotation
    decrypted_message = decrypt(read_message, rotation)
    # Create a name for the decrypted file
    decrypted_filename = filename.gsub("encrypted", "decrypted")
    # Create an output file handle
    output_message = File.open(decrypted_filename, "w")
    # Write out the text
    output_message.write(decrypted_message)
    # Close the file
    output_message.close

  end
  
    def get_lambda(char)
	val = char.sum
	
	dynamicvar = $c
	if (dynamicvar=="" || dynamicvar==nil)
		dynamicvar = 1
	else 
		if (dynamicvar==0)
			dynamicvar = 1
		end
	end
	
	#$c = (dynamicvar * val)/2*(1-(dynamicvar * val)/2)/((dynamicvar * dynamicvar) *2)
	decrypted_char = decrypt(char, $c)
	return decrypted_char
  end
  
  def read_file(filename)
	clear = File.open(filename) #open the file and set it as a variable
	cleartxt = clear.read
	
	#read the file letter by letter and get the corrosponding lambda
	i = 0
	while i <= cleartxt.size
		
		encchar = cleartxt[i..i]
		$end_file = $end_file + get_lambda(encchar)
		
		system "cls"
		puts "#$end_file"
		i+=1
	end
	
	clear.close
  end

end

$end_file=''
e = Encryptor.new

puts "What is the file extension you'd like to decrypt?"
print "> "
file_to_decrypt = gets.chomp
puts "
Secure File Password,"
print "> "
$c = gets.chomp.sum.to_i

e.read_file(file_to_decrypt)

#make the output file
encrypted_filename = file_to_decrypt.sub! '.enc', ''
output_message = File.open(encrypted_filename, "w")
output_message.write($end_file)
output_message.close
puts "Done!"