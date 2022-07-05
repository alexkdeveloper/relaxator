
using Gtk;
using GLib;

namespace Relaxator {

    public class Window : Adw.Window {

        private Bus bus;
        private Gtk.ToggleButton toggle_forest;
        private Gtk.ToggleButton toggle_night;
        private Gtk.ToggleButton toggle_waves;
        private Gtk.ToggleButton toggle_rain;
        private Gtk.ToggleButton toggle_fire;
        private Gtk.ToggleButton toggle_cat;
        private Gst.Element pipeline_forest;
        private Gst.Element pipeline_night;
        private Gst.Element pipeline_waves;
        private Gst.Element pipeline_rain;
        private Gst.Element pipeline_fire;
        private Gst.Element pipeline_cat;
        Gst.Bus forest_bus;
        Gst.Bus night_bus;
        Gst.Bus sea_bus;
        Gst.Bus rain_bus;
        Gst.Bus fire_bus;
        Gst.Bus cat_bus;

        public Window (Adw.Application application) {
            set_application(application);
            player_init ();
            bus = new Bus (pipeline_forest, pipeline_night, pipeline_waves, pipeline_rain, pipeline_fire, pipeline_cat);
            connect_signals ();
        }

        construct {
            this.set_title ("Relaxator");

            toggle_forest = new ToggleButton ();
            toggle_night = new ToggleButton ();
            toggle_waves = new ToggleButton ();
            toggle_rain = new ToggleButton ();
            toggle_fire = new ToggleButton ();
            toggle_cat = new ToggleButton ();

            var image_forest = new Image.from_resource ("/com/github/alexkdeveloper/relaxator/images/forest.svg");
            image_forest.set_size_request (50, 50);
            var image_night = new Image.from_resource ("/com/github/alexkdeveloper/relaxator/images/night.svg");
            image_night.set_size_request (50, 50);
            var image_waves = new Image.from_resource ("/com/github/alexkdeveloper/relaxator/images/waves.svg");
            image_waves.set_size_request (50, 50);
            var image_rain = new Image.from_resource ("/com/github/alexkdeveloper/relaxator/images/rain.svg");
            image_rain.set_size_request (50, 50);
            var image_fire = new Image.from_resource ("/com/github/alexkdeveloper/relaxator/images/fire.svg");
            image_fire.set_size_request (50, 50);
            var image_cat = new Image.from_resource ("/com/github/alexkdeveloper/relaxator/images/cat.svg");
            image_cat.set_size_request (50, 50);

            toggle_forest.set_child (image_forest);
            toggle_night.set_child (image_night);
            toggle_waves.set_child (image_waves);
            toggle_rain.set_child (image_rain);
            toggle_fire.set_child (image_fire);
            toggle_cat.set_child (image_cat);

            var grid = new Grid ();
            grid.vexpand = true;
            grid.halign = Align.CENTER;
            grid.valign = Align.CENTER;
            grid.column_spacing = 50;
            grid.row_spacing = 50;
            grid.margin_bottom = 10;
            grid.margin_top = 10;
            grid.margin_end = 20;
            grid.margin_start = 20;

            grid.attach (toggle_forest, 0, 0, 1, 1);
            grid.attach (toggle_night, 1, 0, 1, 1);
            grid.attach (toggle_waves, 2, 0, 1, 1);
            grid.attach (toggle_rain, 0, 1, 1, 1);
            grid.attach (toggle_fire, 1, 1, 1, 1);
            grid.attach (toggle_cat, 2, 1, 1, 1);

            var headerbar = new Adw.HeaderBar();
            var box = new Box (Orientation.VERTICAL, 0);
            box.append (headerbar);
            box.append (grid);
            set_content (box);
        }

        public void player_init () {
         try {
        	pipeline_forest = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/forest.ogg");
            pipeline_forest.set("volume", 5.0);
            pipeline_night = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/night.ogg");
            pipeline_night.set("volume", 5.0);
            pipeline_waves = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/waves.ogg");
            pipeline_waves.set("volume", 5.0);
            pipeline_rain = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/rain.ogg");
            pipeline_rain.set("volume", 5.0);
            pipeline_fire = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/fire.ogg");
            pipeline_fire.set ("volume", 5.0);
            pipeline_cat = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/cat.ogg");
            pipeline_cat.set ("volume", 5.0);
        	} catch (Error e) {
        		stderr.printf ("Error: %s\n", e.message);
        	}
        }

        public void connect_signals () {

          forest_bus = pipeline_forest.get_bus ();
          forest_bus.add_signal_watch ();
          forest_bus.message.connect (bus.parse_message);

          night_bus = pipeline_night.get_bus ();
          night_bus.add_signal_watch ();
          night_bus.message.connect (bus.parse_message);

          sea_bus = pipeline_waves.get_bus ();
          sea_bus.add_signal_watch ();
          sea_bus.message.connect (bus.parse_message);

          rain_bus = pipeline_rain.get_bus ();
          rain_bus.add_signal_watch ();
          rain_bus.message.connect (bus.parse_message);

          fire_bus = pipeline_fire.get_bus ();
          fire_bus.add_signal_watch ();
          fire_bus.message.connect (bus.parse_message);

          cat_bus = pipeline_cat.get_bus ();
          cat_bus.add_signal_watch ();
          cat_bus.message.connect (bus.parse_message);

          toggle_forest.toggled.connect (() => {
            if(toggle_forest.active){
              pipeline_forest.set_state (Gst.State.PLAYING);
            }
            else {
              pipeline_forest.set_state (Gst.State.PAUSED);
            }
          });

          toggle_night.toggled.connect (() => {
            if(toggle_night.active){
              pipeline_night.set_state (Gst.State.PLAYING);
            }
            else{
              pipeline_night.set_state (Gst.State.PAUSED);
            }
          });

          toggle_waves.toggled.connect (() => {
            if(toggle_waves.active){
              pipeline_waves.set_state (Gst.State.PLAYING);
            }
            else{
              pipeline_waves.set_state (Gst.State.PAUSED);
            }
          });

          toggle_rain.toggled.connect (() => {
            if(toggle_rain.active){
              pipeline_rain.set_state (Gst.State.PLAYING);
            }
            else{
              pipeline_rain.set_state (Gst.State.PAUSED);
            }
          });

          toggle_fire.toggled.connect (() => {
            if(toggle_fire.active){
              pipeline_fire.set_state (Gst.State.PLAYING);
            }
            else{
              pipeline_fire.set_state (Gst.State.PAUSED);
            }
          });

          toggle_cat.toggled.connect (() => {
            if(toggle_cat.active){
              pipeline_cat.set_state (Gst.State.PLAYING);
            }
            else{
              pipeline_cat.set_state (Gst.State.PAUSED);
            }
          });
        }
    }
}
