import allegro5.allegro;
import allegro5.allegro_primitives;
import allegro5.allegro_image;
import allegro5.allegro_font;
import allegro5.allegro_ttf;
import allegro5.allegro_color;

import std.stdio;
import std.conv;
import std.string;
import std.random;
import std.algorithm : remove;

import helper;
import viewport;
import map;

alias KEY_UP = ALLEGRO_KEY_UP; // should we do these? By time we write them out we've already done more work than just writing them.
alias KEY_DOWN = ALLEGRO_KEY_DOWN; // i'll leave them coded as an open question for later
alias KEY_LEFT = ALLEGRO_KEY_LEFT; 
alias KEY_RIGHT = ALLEGRO_KEY_RIGHT; 

alias COLOR = ALLEGRO_COLOR;
alias BITMAP = ALLEGRO_BITMAP;
alias tile=ushort;


// CONSTANTS
//=============================================================================
//struct globals_t
//	{
		
	ALLEGRO_FONT* 	font;
	
	ALLEGRO_BITMAP* dude_up_bmp;
	ALLEGRO_BITMAP* dude_down_bmp;
	ALLEGRO_BITMAP* dude_left_bmp;
	ALLEGRO_BITMAP* dude_right_bmp;
	
	ALLEGRO_BITMAP* chest_bmp;
	ALLEGRO_BITMAP* chest_open_bmp;

	ALLEGRO_BITMAP* dwarf_bmp;
	ALLEGRO_BITMAP* goblin_bmp;
	ALLEGRO_BITMAP* boss_bmp;

	ALLEGRO_BITMAP* fountain_bmp;
	
	ALLEGRO_BITMAP* tree_bmp;

	ALLEGRO_BITMAP* wall_bmp;
	ALLEGRO_BITMAP* grass_bmp;
	ALLEGRO_BITMAP* lava_bmp;
	ALLEGRO_BITMAP* water_bmp;
	
	ALLEGRO_BITMAP* wood_bmp;
	ALLEGRO_BITMAP* stone_bmp;
	ALLEGRO_BITMAP* reinforced_wall_bmp;
	
	ALLEGRO_BITMAP* sword_bmp;
	ALLEGRO_BITMAP* carrot_bmp;
	ALLEGRO_BITMAP* potion_bmp;
	
	ALLEGRO_BITMAP* blood_bmp;

	int SCREEN_W = 1360;
	int SCREEN_H = 720;
//	}
//globals_t g;

import std.format;
void loadResources()	
	{
	//g.atlas.load("./data/atlas.png");
	}

ALLEGRO_BITMAP* getBitmap(string path)
	{
	import std.string : toStringz;
	ALLEGRO_BITMAP* bmp = al_load_bitmap(toStringz(path));
	assert(bmp != null, format("ERROR: Failed to load bitmap [%s]!", path));
	return bmp;
	}

struct statistics_t
	{
	// per frame statistics
	ulong number_of_drawn_particles=0;
	ulong number_of_drawn_objects=0;
	ulong number_of_drawn_structures=0;
	ulong number_of_drawn_dwarves=0;
	ulong number_of_drawn_background_tiles=0;
	
	ulong fps=0;
	ulong frames_passed=0;
	
	void reset()
		{ // note we do NOT reset fps/frames_passed here as they are cumulative or handled elsewhere.
		number_of_drawn_particles = 0;
		number_of_drawn_objects = 0;
		number_of_drawn_structures = 0;
		number_of_drawn_dwarves = 0;
		number_of_drawn_background_tiles = 0;
		}
	}

statistics_t stats;

int mouse_x = 0; //cached, obviously. for helper routines.
int mouse_y = 0;
int mouse_lmb = 0;
int mouse_in_window = 0;
bool key_w_down = false;
bool key_s_down = false;
bool key_a_down = false;
bool key_d_down = false;
bool key_q_down = false;
bool key_e_down = false;
bool key_f_down = false;
bool key_space_down = false;

