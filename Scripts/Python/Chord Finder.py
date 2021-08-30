# Author:   Ashley Bronca
# Name:     Chord Finder.py
#
# Purpose:  Application to help find chord structures 
#           
# Usage:    Run script from a Terminal
#
# Version 1.0.0, 17 December 2019
#
# Use at your own risk. Ashley Bronca will accept no responsibility for loss or damage
# caused by this script.
#
#
##Start of Script



#Full Library

full_library = '\nC maj\n ' '\nD maj\n ' '\nE min\n ' '\nF maj\n ' '\nG maj\n ' '\nA maj\n ' '\nA min\n'

#Chord Structures

cmaj_chord = "C maj : 0|3|2|0|1|0 - You can strum all strings when playing this open chord. There are many inversions of the 'C' chord, this open version being the easiest to master"
dmaj_chord = "D maj : x|x|x|2|3|2 - You can only strum the bottom three strings when playing this open chord. D major chord can be tricky to remember in the way that you cannot play the first three strings!"
emin_chord = "E min : 0|2|2|0|0|0 - You can strum all strings when playing this open chord. The E minor chord is known to be one of the easiest chords you can play. It is in a lot of songs, so master this one!"
fmaj_chord = "F maj : 1|3|3|2|1|1 - You can strum all strings when playing this chord - this is known as a 'Bar Chord'. As with the C major chord, F major also has many inversions and different ways to play it - if you can get used to using the bar chord, you will find adapting to other bar chords much easier in the future."
gmaj_chord = "G maj : 2|1|0|0|0|3 - You can strum all strings when playing this open chord. G major is certainly a favourite amongst songwriters and composers alike. It is imperative that you gain traction on this chord."
amin_chord = "A min : x|0|2|2|1|0 - You can strum all strings except the top string when playing this open chord. Known for it's popularity in pop songs, this is such a great chord to introduce into a plethora of songs. Couple this with a nice C7 or add a 9th to it, you have yourself a keeper!"
amaj_chord = "A maj : x|0|2|2|2|0 - You can strum all strings except the top string when playing this open chord. This one is great to have in your back pocket. A major always creeps up when you least expect it."

#Introduction 

print("Welcome to Ash's chord finder.\n \nYou can find the open chord structure for the most popular chords you will use.\n \nThe layout will be by fret number from top to bottom. Let's get started!")

times_to_repeat = 3

while  times_to_repeat >= 0:

#Asking user if they would like to access the Chord library

      library = input('\nWould you like to see what chords you have access to? Yes / No :\n\n').capitalize()

#if statement - if Yes, show library, if not, continue

      if library == 'Yes':
            print(full_library)
      else:
            print("\nOk, you must have been here before! If you know the chord that you wish to learn, let's get started") 

#First chord to start learning
        
      first_chord = input("\nWhat chord would you like to learn?\n\n").capitalize()

#Chord variables - pulls from the Chord Structures

      if first_chord == "C":
            print(cmaj_chord)
      elif first_chord == "D":
            print(dmaj_chord)
      elif first_chord == "Em":
            print(emin_chord)
      elif first_chord == "F":
            print(fmaj_chord)
      elif first_chord == "G":
            print(gmaj_chord)
      elif first_chord == "Am":
            print(amin_chord)
      elif first_chord == "A":
            print(amaj_chord)
      else:
            print("\nSorry, that is not a valid chord.")

#Continue with the prompt

            Library = input("\nWould you like to access the chord library? Yes / No :\n\n").capitalize()

            if library == 'Yes':
                  print(full_library)
            else:
                  print("\nOk! :)")

            first_chord = input("\nWhat chord would you like to learn?\n\n").capitalize()
      
            if first_chord == "C":
                  print(cmaj_chord)
            elif first_chord == "D":
                  print(dmaj_chord)
            elif first_chord == "Em":
                  print(emin_chord)
            elif first_chord == "F":
                  print(fmaj_chord)
            elif first_chord == "G":
                  print(gmaj_chord)
            elif first_chord == "Am":
                  print(amin_chord)
            elif first_chord == "A":
                  print(amaj_chord)
            else:
            
                  print("\nSorry, that is an invalid chord! Please enter a vaild chord")
            
#Continue with the prompt

                  Library = input("\nWhat chord would you like to learn?\n\n").capitalize()

                  if first_chord == "C":
                        print("\nGreat! ",  cmaj_chord  ,'\n')
                  elif first_chord == "D":
                        print("\nGreat! ",  dmaj_chord  ,"\n")
                  elif first_chord == "Em":
                        print("\nGreat! ",  emin_chord  ,"\n")
                  elif first_chord == "F":
                        print("\nGreat! ",  fmaj_chord  ,"\n")
                  elif first_chord == "G":
                        print("\nGreat! ",  gmaj_chord  ,"\n")
                  elif first_chord == "Am":
                        print("\nGreat! ",  amin_chord  ,"\n")
                  elif first_chord == "A":
                        print("\nGreat! ",  amaj_chord  ,"\n")
                  else:
                        print("\nAnother invalid chord! Sorry that you cannot find a chord that you are after. Perhaps restart the program and check out the chord library.\n")
                  times_to_repeat -= 1


exit





