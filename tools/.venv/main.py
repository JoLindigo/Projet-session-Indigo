import os

from consolemenu import *
from consolemenu.items import *

from constants import CURRENT_DIR
from image_manipulation.sprite_file_converter import convert_sprite_to_pixel_array, convert_sprite_to_ppu_instructions

def convert_image_to_pixel_data_prompt():
  file_name = input("Enter image file name: ")
  convert_sprite_to_pixel_array(file_name)

def convert_image_to_instruction_data_prompt():
  file_name = input("Enter image file name: ")
  convert_sprite_to_ppu_instructions(file_name)

def create_menus():
  main_menu = ConsoleMenu("Ze tools", "We ❤  Jo L'indigo")
  convert_image_to_pixel_data_function_item = FunctionItem("Convert sprite file to pixel array", convert_image_to_pixel_data_prompt)
  convert_image_to_instruction_function_item = FunctionItem("Convert sprite file to instruction array", convert_image_to_instruction_data_prompt)
  main_menu.append_item(convert_image_to_pixel_data_function_item)
  main_menu.append_item(convert_image_to_instruction_function_item)
  
  main_menu.show()

def main():
    create_menus()

if __name__ == "__main__":
    main()