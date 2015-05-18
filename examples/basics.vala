/*
The MIT License (MIT)

Copyright (c) <2013> <SDL2.0 vapi>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
//FOR: SDL2.0 - This is not official, to be futurely changed for the official binding
//Maintainer: PedroHLC, Txasatonga, Desiderantes

// Compilation command:
// valac -o "basics" --pkg gee-1.0 --pkg sdl2 --pkg sdl2-gfx --pkg sdl2-ttf --pkg sdl2-image --pkg sdl2-mixer -X -lSDL2_image  -X -lSDL2_ttf -X -lSDL2_mixer -X -lSDL2_gfx "basics.vala"

using SDL;
using SDLImage;
using SDLTTF;
using SDLMixer;


public class Example 
	{
	protected static SDL.Window window;
	protected static SDL.Renderer? window_renderer;

	public static void main()	{
		SDL.init (SDL.InitFlag.EVERYTHING| SDLImage.InitFlags.ALL);
		SDLTTF.init();
		
		window = new SDL.Window("Testing SDL 2.0 in Vala: Keyboard, Textures and Sound", Window.POS_CENTERED, Window.POS_CENTERED, 800,600, WindowFlags.RESIZABLE);
		var a= SDLMixer.open(44100,Audio.Format.S16LSB,2,4096); stdout.printf("%d\n",a);
		window_renderer = Renderer.create(window, -1, SDL.RendererFlags.ACCELERATED | SDL.RendererFlags.PRESENTVSYNC);
		window.show();
		assert(window_renderer == null);
		// Open surface and after transform to texture
		SDL.Surface img= SDLImage.load("boy.png");
		var texture_img= Texture.create_from_surface (window_renderer, img);		
		assert(texture_img ==null);
		// Load music
		Music sfx= new Music("yahoo.ogg");
		
		// Load font as surface and transform to texture.
		Font font= new Font("KatamotzIkasi.ttf", 30);
		string text;
		int seconds;
		int percentage;
		switch (SDL.get_power_info( out seconds, out percentage)){
			case SDL.PowerState.ON_BATTERY :
				text = "Your battery has %d %% charge, approximately %d minutes".printf(percentage, seconds/60);
				break;
			case SDL.PowerState.CHARGING:
				text = "You battery is charging and it's at %d %% of its capacity".printf(percentage);
				break;
			case SDL.PowerState.CHARGED:
				text = "Your battery is fully charged. Hooray!";
				break;
			case SDL.PowerState.NO_BATTERY:
				text = "Your system is not using a battery. Why would you do that?";
				break;
			case SDL.PowerState.UNKNOWN:
			default:
				text = "We don't really know what's going on with your system energy";
				break;
		}
		SDL.Surface info= font.render_blended_wrapped_utf8(text, {10,10,10,255}, 240);
		var texture_info = Texture.create_from_surface(window_renderer, info);	
		assert(texture_info ==null);
		var row =0;
		var column =0;
		//Main loop
		for (Event e = {0}; e.type != EventType.QUIT; Event.poll(out e)){
			window_renderer.clear();
			window_renderer.set_draw_color(100, 200, 200, 250);
			window_renderer.fill_rect( {0, 0, 800, 600} ) ;
			
			if (e.type==EventType.KEYDOWN){
				if ( e.key.keysym.sym== Keycode.DOWN){
					row+=10;
				}
				if ( e.key.keysym.sym== Keycode.UP){
					row-=10;
				}
					
				if ( e.key.keysym.sym== Keycode.LEFT){
					column-=20;
				}
				if ( e.key.keysym.sym== Keycode.RIGHT){
					column+=20;
				}
				if ( e.key.keysym.sym== Keycode.SPACE){ // When press space sounds.
					sfx.play(1);
				}
			}
		window_renderer.copy(texture_img, {0, 0, img.w, img.h} , {column, row, img.w*2, img.h*2});
		window_renderer.copy(texture_info, {0, 0, info.w, info.h} , {500, 400, info.w, info.h});			window_renderer.present();
		window.update_surface();
		SDL.Timer.delay(10);
		}
	SDL.quit();
	}
}
