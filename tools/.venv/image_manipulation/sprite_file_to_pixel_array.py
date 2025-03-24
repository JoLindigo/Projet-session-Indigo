import numpy as np
import os
import png

from PIL import Image
from constants import CURRENT_DIR

def convert_sprite_to_pixel_array(file_name: str):
  file_exists = os.path.exists(os.path.join(CURRENT_DIR, file_name))
  if not file_exists:
    raise FileNotFoundError("Provided file does not exist on the system.")
  
  reader = png.Reader(filename=os.path.join(CURRENT_DIR, file_name))
  _, _, pixels, metadata = reader.read_flat()
  pixel_byte_width = 4 if metadata['alpha'] else 3
  
  with open(os.path.join(CURRENT_DIR, f"{file_name.split(".png")[0]}_out.txt"), 'w') as output_file:
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