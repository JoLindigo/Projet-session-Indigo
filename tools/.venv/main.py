import os

from consolemenu import *
from consolemenu.items import *

from constants import CURRENT_DIR
from image_manipulation.sprite_file_to_pixel_array import convert_sprite_to_pixel_array

def convert_image_prompt():
  file_name = input("Enter image file name: ")
  convert_sprite_to_pixel_array(file_name)

def create_menus():
  main_menu = ConsoleMenu("Ze tools", "We ❤  Jo L'indigo")
  convert_image_function_item = FunctionItem("Convert sprite file to pixel array", convert_image_prompt)
  main_menu.append_item(convert_image_function_item)
  
  main_menu.show()

def main():
    create_menus()

if __name__ == "__main__":
    main()