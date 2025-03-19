#ifndef _PPU_H_
#define _PPU_H_

#include "../../common.h"
#include "ppu_instruction_formats.h"

#define OPCODE_SETACTORTILECOLOR      0b0000U
#define OPCODE_SETBACKGROUNDTILECOLOR 0b0001U
#define OPCODE_SETACTORTILEID         0b0010U
#define OPCODE_SETBACKGROUNDTILEID    0b0011U
#define OPCODE_MOVEACTORPOSITION      0b0100U
#define OPCODE_SETACTORPOSITION       0b0101U
#define OPCODE_SETVIEWPORTOFFSET      0b0110U

/**
  * \brief Initialize the components to their default state on the PPU.
  */
void PPU_Init();


/**
  * \brief Sets a new offset for the viewport to change the displayed game tiles.
  * \param[in] x Contains the new position in x to set the viewport to.
  * \param[in] y Contains the new position in y to set the viewport to.
  */
void PPU_SetViewportOffset(uint16_t x, uint16_t y);


/**
  * \brief Sets a new ID for a tile within the background buffer in the PPU.
  * \param[in] tileColIndex Contains the column index of the background buffer to select the tile from.
  * \param[in] tileRowIndex Contains the row index of the background buffer to select the tile from.
  * \param[in] tileID Contains the new tile ID that will be assigned to the tile at the provided indexes.
  */
void PPU_SetBackgroundTileID(uint8_t tileColIndex, uint8_t tileRowIndex, uint8_t tileID);


/**
  * \brief Sets a new color to a pixel for a specified tile ID within the background tile buffer.
  * \param[in] pixelColIndex Contains the column index of the tile to select the pixel from.
  * \param[in] pixelRowIndex Contains the row index of the tile to select the pixel from.
  * \param[in] tileID Contains the tile ID that will have its pixel color changed.
  * \param[in] pixelColorCode Contains the pixel color code that will be assigned to the specified pixel.
  */
void PPU_SetBackgroundTileColor(uint8_t pixelColIndex, uint8_t pixelRowIndex, uint8_t tileID, uint8_t pixelColorCode);


/**
  * \brief Sets a new ID for the specified actor.
  * \param[in] actorID Contains the actor ID that will have its tile ID changed.
  * \param[in] tileID Contains the new tile ID that will be assigned to the actor.
  */
void PPU_SetActorTileID(uint8_t actorID, uint8_t tileID);


/**
  * \brief Sets a new color to a pixel for a specified tile ID within the actor tile buffer.
  * \param[in] pixelColIndex Contains the column index of the tile to select the pixel from.
  * \param[in] pixelRowIndex Contains the row index of the tile to select the pixel from.
  * \param[in] tileID Contains the tile ID that will have its pixel color changed.
  * \param[in] pixelColorCode Contains the pixel color code that will be assigned to the specified pixel.
  */
void PPU_SetActorTileColor(uint8_t pixelColIndex, uint8_t pixelRowIndex, uint8_t tileID, uint8_t pixelColorCode);


/**
  * \brief Sets an actor's absolute position.
  * \param[in] x Contains the new position in the x axis to set the actor to.
  * \param[in] y Contains the new position in the y axis to set the actor to.
  * \param[in] actorID Contains the actor ID that will have its global position changed.
  */
void PPU_SetActorPosition(uint16_t x, uint16_t y, uint8_t actorID);


/**
  * \brief Moves an actor's position.
  * \param[in] deltaX Contains the amount of pixel in the x axis that the actor has moved.
  * \param[in] deltaY Contains the amount of pixel in the y axis that the actor has moved.
  * \param[in] actorID Contains the actor ID that will have its position changed.
  */
void PPU_MoveActorPosition(uint8_t deltaX, uint8_t deltaY, uint8_t actorID);

#endif // _PPU_H_
