
using Gtk;
using GLib;

namespace Relaxator {

    const int MIN_WIDTH = 100;
    const int MIN_HEIGHT = 100;

    public class Window : Gtk.Window {

        private Gtk.Grid                    grid;            // Container for everything
        private Gtk.Revealer                reveal;
        private Gtk.Revealer                reveal_1;
        private Gtk.Revealer                reveal_2;
        private Bus                         bus;
        private Gtk.ToggleButton        toggle_forest;
        private Gtk.ToggleButton        toggle_night;
        private Gtk.ToggleButton        toggle_waves;
        private Gtk.ToggleButton        toggle_rain;
        private Gtk.Scale               volume1;
        private Gtk.Scale               volume2;
        private Gtk.Scale               volume3;
        private Gtk.Scale               volume4;
        public Gst.Element              pipeline_forest;
        private Gst.Element             pipeline_night;
        private Gst.Element             pipeline_waves;
        private Gst.Element             pipeline_rain;
        Gst.Bus                         forest_bus;
        Gst.Bus                         night_bus;
        Gst.Bus                         sea_bus;
        Gst.Bus                         rain_bus;

        private signal void change_colour();

        public Window (Gtk.Application application) {

            set_application(application);

            Gdk.Geometry geo = Gdk.Geometry();
            geo.min_width = MIN_WIDTH;
            geo.min_height = MIN_HEIGHT;
            geo.max_width = 1024;
            geo.max_height = 648;

            this.set_geometry_hints(null, geo, Gdk.WindowHints.MIN_SIZE | Gdk.WindowHints.MAX_SIZE);

            grid = new Gtk.Grid ();
            reveal = new Gtk.Revealer ();
            reveal_1 = new Gtk.Revealer ();
            reveal_2 = new Gtk.Revealer ();

            setup_ui ();    // Set up the GUI
            player_init ();
            bus = new Bus (pipeline_forest, pipeline_night, pipeline_waves, pipeline_rain);
            connect_signals ();
            get_style_context ().add_class ("rounded");
        }

        /**
         * Builds all of the widgets and arranges them in the window.
         */
        private void setup_ui () {
            this.set_title ("Relaxator");

            toggle_forest = new Gtk.ToggleButton ();
            toggle_night = new Gtk.ToggleButton ();
            toggle_waves = new Gtk.ToggleButton ();
            toggle_rain = new Gtk.ToggleButton ();

            toggle_forest.image = new Gtk.Image.from_resource ("/com/github/alexkdeveloper/relaxator/icons/forest.svg");
            toggle_night.image = new Gtk.Image.from_resource ("/com/github/alexkdeveloper/relaxator/icons/night.svg");
            toggle_waves.image = new Gtk.Image.from_resource ("/com/github/alexkdeveloper/relaxator/icons/waves.svg");
            toggle_rain.image = new Gtk.Image.from_resource ("/com/github/alexkdeveloper/relaxator/icons/rain.svg");

            toggle_forest.add_events (Gdk.EventMask.SCROLL_MASK);
            toggle_night.add_events (Gdk.EventMask.SCROLL_MASK);
            toggle_waves.add_events (Gdk.EventMask.SCROLL_MASK);
            toggle_rain.add_events (Gdk.EventMask.SCROLL_MASK);

            toggle_forest.get_style_context ().add_class ("button");
            toggle_night.get_style_context ().add_class ("button");
            toggle_waves.get_style_context ().add_class ("button");
            toggle_rain.get_style_context ().add_class ("button");

            var headerbar = new Gtk.HeaderBar ();
            headerbar.title = "Relaxator";
            headerbar.get_style_context().add_class("flat");
            headerbar.show_close_button = true;
            set_titlebar(headerbar);

            volume1 = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0, 8, 1);
            volume1.set_draw_value (false);
            volume1.set_value (7);
            volume1.round_digits = 0;

            volume2 = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0, 8, 1);
            volume2.set_draw_value (false);
            volume2.set_value (7);
            volume2.round_digits = 0;

            volume3 = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0, 8, 1);
            volume3.set_draw_value (false);
            volume3.set_value (7);
            volume3.round_digits = 0;

            volume4 = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 0, 8, 1);
            volume4.set_draw_value (false);
            volume4.set_value (7);
            volume4.round_digits = 0;

            reveal.set_transition_duration (800);
            reveal_1.set_transition_duration (800);
            reveal_2.set_transition_duration (800);

            reveal_1.valign = Gtk.Align.START;
            reveal_2.valign = Gtk.Align.START;

            grid.halign = Gtk.Align.CENTER;
            grid.valign = Gtk.Align.CENTER;
            grid.column_spacing = 50;
            grid.margin_bottom = 10;
            grid.margin_top = 10;
            grid.margin_end = 20;
            grid.margin_start = 20;

            grid.attach (toggle_forest, 1, 1, 1, 1);
            grid.attach (toggle_night, 2, 1, 1, 1);
            grid.attach (toggle_waves, 3, 1, 1, 1);
            grid.attach (toggle_rain, 4, 1, 1, 1);
            add(grid);
            show_all();
        }

        public void player_init () {
          // Build the pipeline:
        	try {
        		pipeline_forest = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/forest.ogg");
            pipeline_forest.set("volume", 5.0);
            pipeline_night = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/night.ogg");
            pipeline_night.set("volume", 5.0);
            pipeline_waves = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/waves.ogg");
            pipeline_waves.set("volume", 5.0);
            pipeline_rain = Gst.parse_launch ("playbin uri=resource:/com/github/alexkdeveloper/relaxator/sounds/rain.ogg");
            pipeline_rain.set("volume", 5.0);
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

          volume1.value_changed.connect (() => {
            pipeline_forest.set("volume", volume1.get_value ());
            toggle_forest.opacity = volume1.get_value () / 10 + 0.2;
          });

          volume2.value_changed.connect (() => {
            pipeline_night.set("volume", volume2.get_value ());
            toggle_night.opacity = volume2.get_value () / 10 + 0.2;
          });

          volume3.value_changed.connect (() => {
            pipeline_waves.set("volume", volume3.get_value ());
            toggle_waves.opacity = volume3.get_value () / 10 + 0.2;
          });

          volume4.value_changed.connect (() => {
            pipeline_rain.set("volume", volume4.get_value ());
            toggle_rain.opacity = volume4.get_value () / 10 + 0.2;
          });

          toggle_forest.scroll_event.connect (on_scroll_event);
          toggle_night.scroll_event.connect (on_scroll_event_2);
          toggle_waves.scroll_event.connect (on_scroll_event_3);
          toggle_rain.scroll_event.connect (on_scroll_event_4);

          toggle_forest.toggled.connect (() => {
            if(toggle_forest.active){
              pipeline_forest.set_state (Gst.State.PLAYING);
              toggle_forest.get_style_context ().add_class ("activated");
            }
            else {
              pipeline_forest.set_state (Gst.State.PAUSED);
              toggle_forest.get_style_context ().remove_class ("activated");
            }
            change_colour();
          });

          toggle_night.toggled.connect (() => {
            if(toggle_night.active){
              pipeline_night.set_state (Gst.State.PLAYING);
              toggle_night.get_style_context ().add_class ("activated");
            }
            else{
              pipeline_night.set_state (Gst.State.PAUSED);
              toggle_night.get_style_context ().remove_class ("activated");
            }
            change_colour();
          });

          toggle_waves.toggled.connect (() => {
            if(toggle_waves.active){
              pipeline_waves.set_state (Gst.State.PLAYING);
              toggle_waves.get_style_context ().add_class ("activated");
            }
            else{
              pipeline_waves.set_state (Gst.State.PAUSED);
              toggle_waves.get_style_context ().remove_class ("activated");
            }
            change_colour();
          });

          toggle_rain.toggled.connect (() => {
            if(toggle_rain.active){
              pipeline_rain.set_state (Gst.State.PLAYING);
              toggle_rain.get_style_context ().add_class ("activated");
            }
            else{
              pipeline_rain.set_state (Gst.State.PAUSED);
              toggle_rain.get_style_context ().remove_class ("activated");
            }
            change_colour();
          });
        }

        private bool on_scroll_event (Gdk.EventScroll e) {

          if(e.direction == Gdk.ScrollDirection.UP)
            volume1.move_slider(Gtk.ScrollType.STEP_DOWN);
          if(e.direction == Gdk.ScrollDirection.DOWN)
            volume1.move_slider(Gtk.ScrollType.STEP_UP);

          return true;
        }

        private bool on_scroll_event_2 (Gdk.EventScroll e) {

          if(e.direction == Gdk.ScrollDirection.UP)
            volume2.move_slider(Gtk.ScrollType.STEP_DOWN);
          if(e.direction == Gdk.ScrollDirection.DOWN)
            volume2.move_slider(Gtk.ScrollType.STEP_UP);

          return true;
        }

        private bool on_scroll_event_3 (Gdk.EventScroll e) {

          if(e.direction == Gdk.ScrollDirection.UP)
            volume3.move_slider(Gtk.ScrollType.STEP_DOWN);
          if(e.direction == Gdk.ScrollDirection.DOWN)
            volume3.move_slider(Gtk.ScrollType.STEP_UP);

          return true;
        }

        private bool on_scroll_event_4 (Gdk.EventScroll e) {

          if(e.direction == Gdk.ScrollDirection.UP)
            volume4.move_slider(Gtk.ScrollType.STEP_DOWN);
          if(e.direction == Gdk.ScrollDirection.DOWN)
            volume4.move_slider(Gtk.ScrollType.STEP_UP);

          return true;
        }

        public bool main_quit () {
            this.destroy ();
            return false;
        }
    }
}
