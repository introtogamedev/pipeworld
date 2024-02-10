// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
gpu_set_tex_filter(false);

#macro TILES_NAME "Collision"

function Level_Collision(i_x,i_y){
    return tile_get_empty((tilemap_get_at_pixel(layer_tilemap_get_id(TILES_NAME),i_x,i_y)));
}