import numpy as np
import os
import png

from PIL import Image
from constants import CURRENT_DIR

hex_colors_to_ppu_color_codes = {
  "0x000000": "00000",
  "0x9b8787": "00001",
  "0xac3232": "00010"
}

def convert_sprite_to_ppu_instructions(file_name: str):
  file_exists = os.path.exists(os.path.join(CURRENT_DIR, file_name))
  if not file_exists:
    raise FileNotFoundError("Provided file does not exist on the system.")
    
  reader = png.Reader(filename=os.path.join(CURRENT_DIR, file_name))
  _, _, pixels, metadata = reader.read_flat()
  pixel_byte_width = 4 if metadata['alpha'] else 3

  with open(os.path.join(CURRENT_DIR, f"{file_name.split('.png')[0]}_tile_id_instructions.txt"), 'w') as tile_id_inst_file, \
       open(os.path.join(CURRENT_DIR, f"{file_name.split('.png')[0]}_tile_color_instructions.txt"), 'w') as tile_color_inst_file:
    tile_id_inst_file.write("int tile_id_instructions[] {")
    tile_color_inst_file.write("int tile_color_instructions[] {")
    
    tile_id_instruction_builder = ""
    tile_color_instruction_builder = ""

    current_row = 0
    current_column = 0

    for i in range(0, 128):

      for j in range(0, 128):
        if j != 0:
          tile_id_inst_file.write(',')

        tile_id_inst_file.write("\n")

        tile_id_instruction_builder += "    0100"
        tile_id_instruction_builder += "0001"
        tile_id_instruction_builder += f"{i:07b}"
        tile_id_instruction_builder += f"{j:07b}"
        tile_id_instruction_builder += "0000000000"

        tile_id_inst_file.write(tile_id_instruction_builder)
        tile_id_instruction_builder = ""

    current_row = 0
    current_column = 0

    for i in range(0, len(pixels), pixel_byte_width):
      if i != 0:
        tile_color_inst_file.write(',')
        
      if i % 8 == 0:
        current_row += 1
        current_column = 0
      else:
        current_column += 1

      tile_color_inst_file.write("\n")
      pixel = pixels[i:i+pixel_byte_width]
      pixel_data_str = "0x"
      
      for p in pixel:
        pixel_data_str += hex(p)[2:]
        
      tile_color_instruction_builder += "    0010"
      tile_color_instruction_builder += "0001"
      tile_color_instruction_builder += f"{current_row:03b}"
      tile_color_instruction_builder += f"{current_column:03b}"
      color_key_without_alpha = pixel_data_str[:-2]
      tile_color_instruction_builder += hex_colors_to_ppu_color_codes[color_key_without_alpha]
      tile_color_instruction_builder += "0000000000000"
      tile_color_instruction_builder = tile_color_instruction_builder[:32]
        
      tile_color_inst_file.write(tile_color_instruction_builder)
      tile_color_instruction_builder = ""
    tile_id_inst_file.write("\n}")
    tile_color_inst_file.write("\n}")


def convert_sprite_to_pixel_array(file_name: str):
  file_exists = os.path.exists(os.path.join(CURRENT_DIR, file_name))
  if not file_exists:
    raise FileNotFoundError("Provided file does not exist on the system.")
  
  reader = png.Reader(filename=os.path.join(CURRENT_DIR, file_name))
  _, _, pixels, metadata = reader.read_flat()
  pixel_byte_width = 4 if metadata['alpha'] else 3
  
  with open(os.path.join(CURRENT_DIR, f"{file_name.split('.png')[0]}_out.txt"), 'w') as output_file:
    output_file.write("int sprite_frame_colors[] {")
    
    for i in range(0, len(pixels), pixel_byte_width):
      if i != 0:
        output_file.write(',')
        
      output_file.write("\n")
      pixel = pixels[i:i+pixel_byte_width]
      pixel_data_str = "    0x"
      
      for p in pixel:
        pixel_data_str += hex(p)[2:]
        
      pixel_data_str_split = pixel_data_str.split('x')
              
      if len(pixel_data_str_split[1]) == 4:
        pixel_data_str = pixel_data_str_split[0] + "x0000" + pixel_data_str_split[1]
      elif len(pixel_data_str_split[1]) == 5:
        pixel_data_str = pixel_data_str_split[0] + "x000" + pixel_data_str_split[1]
        
      output_file.write(pixel_data_str)
    output_file.write("\n}")

def is_hex_rgba_null(rgba_hex_code: str) -> bool:
  return rgba_hex_code == "0x00000000"