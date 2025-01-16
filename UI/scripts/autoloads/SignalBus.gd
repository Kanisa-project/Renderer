extends Node

signal gaym_changed(new_gaym: String)

signal masterpiece_changed(new_masterpiece_idutc: String)
signal artribute_changed(adjusted_artribute: Dictionary)
signal base_color_changed(new_color: Color)
signal primary_color_changed(new_color: Color)
signal secondary_color_changed(new_color: Color)
signal thirdary_color_changed(new_color: Color)


#signal letter_guess(letter)
#signal hangman_guess_letter(letter)

signal switch_to_glyth
signal switch_to_glyph
signal switch_to_wordie
signal switch_to_recipe
signal switch_to_foto
signal switch_to_spirite
signal switch_to_gaym
signal switch_to_mujic

signal masterpiece_update_tick(value_change: bool, new_tick_speed: int)
signal masterpiece_update_tock(value_changed: bool, new_tock_speed: float)

signal tab_bar_time_change

signal glyth_change_active(glyth_btn_array: Array)

signal glyph_change_active(glyph_btn_array: Array)

signal recipe_prev
signal recipe_next
signal recipe_reload_book

signal foto_prev
signal foto_next
signal foto_change_input_dict(new_input_dict: Dictionary)

signal spirite_switch_cycling
signal spirite_change_spirite
signal spirite_layer_sprite_changed(layer_num: int, new_layer: Texture)
signal spirite_layer_color_changed(layer_num: int, new_color: Color)

signal wordie_reading_timer

#signal start_searching_word
#signal end_searching_word
#
#signal bored_taker_capture
#signal bored_taker_check
