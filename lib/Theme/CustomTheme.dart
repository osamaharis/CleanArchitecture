import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Utils/Extensions.dart';

final _border = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(
      color: very_light_grey, width: 2, style: BorderStyle.solid),
);


//const theme_color = "#c39547";
const theme_color = "#6B5FBE";

const purpule = Color(0xFF5117AC);
const light_green = Color(0x741ED9B4);

const green = Color(0xFF108228);
const dark = Color(0xFF212121);
const grey = Color(0xFF404040);
const light_grey = Color(0xFF666666);
const very_light_grey = Color(0xFFB3B3B3);
const shimmer_grey = Color(0xB3B3B3B3);
const shimmer_shade_grey = Color(0x1AB3B3B3);
const circular_bg_color = Color(0x33B3B3B3);
const white = Color(0xFFFFFFFF);
const pink = Color(0xFFD023B5);
const task_cardviewbg="#EAD2A7";
const tabbarbg="#D2B177";
const tabcolor="#FFE7BC";
const in_progress_color = "#0747A6";
const to_do_color = "#758195";
const completed_color = "#758195";
const dark_red = "#892621";
const back_icon_color = "#181617";
const input_field_border_color = "#E2E8F0";
const last_transaction_txt_color = "#181617";
const tab_bar_txt_color = "#707070";
const tab_bar_islamic_txt_color = "#007D84";
const notification_txt_color = "#3F3C3C";
const black = "#000000";
const investment_tool_bg = "#F5F5F5";
const investment_tool_border = "#EBECF0";
const return_calc_txt_color = "#707070";
const stepper_counter_bg_color = "#FCE6E5";

const input_hint_color ="#BBBBBB";
const input_hint_head_color = "#181617";
const search_txt_bg_color = "#F6F6F6";
final int mainHeading = 20;
const int subHeading = 13;
const int hintText = 15;
const int otherText = 12;
const double bottom_navigation_font_size = 12.0;
const int plain_text_size = 14;
const int text_above_textfield = 13;
const int version_text = 10;
const double custom_btn_text_size = 16.0;
const int e_system_generate_pin_text = 16;
const double heading_text_size = 16.0;
const double other=12;
const double risk_heading = 22.0;
const double risk_text_size = 18.0;

class CustomTheme {
  final main_theme = ThemeData(
      bottomAppBarColor: light_grey,
      appBarTheme: AppBarTheme(
        color: theme_color.toColor(),
      ),
      textTheme: TextTheme(),

      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: input_field_border_color.toColor(), width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme_color.toColor(), width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          isDense: true,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[500])),
      fontFamily: "Montserrat",

      iconTheme: IconThemeData(
        color: theme_color.toColor(),
      ));


}
