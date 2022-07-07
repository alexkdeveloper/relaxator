

using Gst;

namespace Relaxator {

  public class Bus {

    private Element pipeline_forest;
    private Element pipeline_night;
    private Element pipeline_sea;
    private Element pipeline_rain;
    private Element pipeline_fire;
    private Element pipeline_cat;
    private Element pipeline_city;
    private Element pipeline_stream;
    private Element pipeline_train;

    public Bus (Element pipeline_forest, Element pipeline_night, Element pipeline_sea, Element pipeline_rain, Element pipeline_fire, Element pipeline_cat, Element pipeline_city, Element pipeline_stream, Element pipeline_train) {
        this.pipeline_forest = pipeline_forest;
        this.pipeline_night = pipeline_night;
        this.pipeline_sea = pipeline_sea;
        this.pipeline_rain = pipeline_rain;
        this.pipeline_fire = pipeline_fire;
        this.pipeline_cat = pipeline_cat;
        this.pipeline_city = pipeline_city;
        this.pipeline_stream = pipeline_stream;
        this.pipeline_train = pipeline_train;
    }

    public void parse_message (Message message){
      if (message != null) {
        switch (message.type) {
        case Gst.MessageType.ERROR:
          GLib.Error err;
          string debug_info;

          message.parse_error (out err, out debug_info);
          stderr.printf ("Error received from element %s: %s\n", message.src.name, err.message);
          stderr.printf ("Debugging information: %s\n", (debug_info != null)? debug_info : "none");
          break;

        case Gst.MessageType.EOS:
          stdout.puts ("End-Of-Stream reached.\n");

          if(message.src == this.pipeline_forest){
            this.pipeline_forest.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_forest.set_state (Gst.State.NULL);
            this.pipeline_forest.set_state (Gst.State.PLAYING);
          }

          if(message.src == this.pipeline_night){
            this.pipeline_night.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_night.set_state (Gst.State.NULL);
            this.pipeline_night.set_state (Gst.State.PLAYING);
          }

          if(message.src == this.pipeline_sea){
            this.pipeline_sea.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_sea.set_state (Gst.State.NULL);
            this.pipeline_sea.set_state (Gst.State.PLAYING);
          }

          if(message.src == this.pipeline_rain){
            this.pipeline_rain.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_rain.set_state (Gst.State.NULL);
            this.pipeline_rain.set_state (Gst.State.PLAYING);
          }

          if(message.src == this.pipeline_fire){
            this.pipeline_fire.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_fire.set_state (Gst.State.NULL);
            this.pipeline_fire.set_state (Gst.State.PLAYING);
          }

          if(message.src == this.pipeline_cat){
            this.pipeline_cat.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_cat.set_state (Gst.State.NULL);
            this.pipeline_cat.set_state (Gst.State.PLAYING);
          }

          if(message.src == this.pipeline_city){
            this.pipeline_city.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_city.set_state (Gst.State.NULL);
            this.pipeline_city.set_state (Gst.State.PLAYING);
          }

          if(message.src == this.pipeline_stream){
            this.pipeline_stream.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_stream.set_state (Gst.State.NULL);
            this.pipeline_stream.set_state (Gst.State.PLAYING);
          }

          if(message.src == this.pipeline_train){
            this.pipeline_train.seek_simple (Gst.Format.TIME,  Gst.SeekFlags.FLUSH | Gst.SeekFlags.KEY_UNIT, 0);
            this.pipeline_train.set_state (Gst.State.NULL);
            this.pipeline_train.set_state (Gst.State.PLAYING);
          }
          break;

        case Gst.MessageType.STATE_CHANGED:
            Gst.State old_state;
            Gst.State new_state;
            Gst.State pending_state;

            message.parse_state_changed (out old_state, out new_state, out pending_state);
            break;
        }
      }
    }
  }
}
