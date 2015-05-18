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
//FOR: SDL2.0.3 - This is not official, to be futurely changed for the official binding
//Maintainer: PedroHLC, Txasatonga, Desiderantes

[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL.h")]
namespace SDL {
	///
	/// Initialization
	///
	/**
	 * These flags can be OR'd together.
	 */
	[Flags, CCode (cname="int", cprefix="SDL_INIT_")]
	public enum InitFlag {
		/**
		 * timer subsystem
		 */
		TIMER,
		/**
		 * audio subsystem
		 */
		AUDIO,
		/**
		 * video subsystem
		 */
		VIDEO,
		/**
		 * joystick subsystem
		 */
		JOYSTICK,
		/**
		 * haptic (force feedback) subsystem
		 */
		HAPTIC,
		/**
		 * controller subsystem
		 */
		GAMECONTROLLER,
		/**
		 * events subsystem
		 */
		EVENTS,
		/**
		 * All of the above subsystems beside.
		 */
		EVERYTHING,
		/**
		 * Prevents SDL from catching fatal signals.
		 */
		NOPARACHUTE
	}// InitFlag

	/**
	 * Use this function to initialize the SDL library. This must be called before using any other SDL function.
	 *
	 * All subsystems are initialized by default.
	 *
	 * If you want to initialize subsystems separately you would call:
	 *
	 * {{{
	 * SDL.init(0);
	 * }}}
	 *
	 * followed by {@link SDL.init_subsystem} with the desired subsystem flag.
	 *
	 * @param flags subsystem initialization flags.
	 *
	 * @return Returns 0 on success or a negative error code on failure; call {@link SDL.get_error} for more information.
	 */
	[CCode (cname="SDL_Init")]
	public static int init(uint32 flags = SDL.InitFlag.EVERYTHING);

	/**
	 * Use this function to initialize specific SDL subsystems.
	 *
	 * {@link SDL.init} initializes assertions and crash protection and then calls {@link SDL.init_subsystem}.
	 * If you want to bypass those protections you can call {@link SDL.init_subsystem} directly.
	 *
	 * Subsystem initialization is ref-counted, you must call {@link SDL.quit_subsystem} for each {@link SDL.init_subsystem}
	 * to correctly shutdown a subsystem manually (or call {@link SDL.quit} to force shutdown).
	 * If a subsystem is already loaded then this call will increase the ref-count and return.
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 *
	 * @return Returns 0 on success or a negative error code on failure; call {@link SDL.get_error} for more information.
	 */
	[CCode (cname="SDL_InitSubSystem")]
	public static int init_subsystem(uint32 flags);

	/**
	 * Use this function to return a mask of the specified subsystems which have previously been initialized.
	 *
	 * Examples:
	 * {{{
	 * // Get init data on all the subsystems
	 * uint32 subsystemInit = SDL.get_initialized(SDL.InitFlag.EVERYTHING);
	 * if (subsystemInit & SDL.InitFlag.VIDEO)
	 *   //Video is initalized
	 * }}}
	 * {{{
	 * // Just check for one specific subsystem
	 * if (SDL.get_initialized(SDL.InitFlag.VIDEO) != 0)
	 *   //Video is initialized
	 * }}}
	 * {{{
	 * // Check for two subsystems
	 * uint32 mask = SDL.InitFlag.VIDEO | SDL.InitFlag.AUDIO;
	 * if (SDL.get_initialized(mask) == mask)
	 *   //Video and Audio is initialized
	 * }}}
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 *
	 * @return If flags is 0 it returns a mask of all initialized subsystems, otherwise it returns the initialization status of the specified subsystems.
	 * The return value does not include {@link SDL.InitFlag.NOPARACHUTE}.
	 */
	[CCode (cname="SDL_WasInit")]
	public static uint32 get_initialized(uint32 flags);


	/**
	 * Use this function to clean up all initialized subsystems. You should call it upon all exit conditions.
	 *
	 * You should call this function even if you have already shutdown each initialized subsystem with {@link SDL.quit_subsystem}.
	 * It is safe to call this function even in the case of errors in initialization.
	 *
	 * If you start a subsystem using a call to that subsystem's init function (for example {@link SDL.Video.init})
	 * instead of {@link SDL.init} or {@link SDL.init_subsystem}, then you must use that subsystem's quit function ({@link SDL.Video.quit})
	 * to shut it down before calling {@link SDL.quit}.
	 */
	[CCode (cname="SDL_Quit")]
	public static void quit();

	/**
	 * Use this function to shut down specific SDL subsystems.
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 */
	[CCode (cname="SDL_QuitSubSystem")]
	public static void quit_subsystem(uint32 flags);

	//
	// CPU Info
	//

	[CCode (cheader_filename="SDL2/SDL_version.h")]
	namespace CPU{
		[CCode (cname ="SDL_GetCPUCacheLineSize", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static int get_cache_line_size();
		//Actual function name was misleading, you get logical core count, not physical CPU count		
		[CCode (cname ="SDL_GetCPUCount", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static int get_num_cores();
		
		[CCode (cname ="SDL_GetSystemRAM", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static int get_system_ram();
		
		[CCode (cname ="SDL_Has3DNow", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_3dnow();
		
		[CCode (cname ="SDL_HasAVX", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_avx();
		
		[CCode (cname ="SDL_HasAVX2", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_avx2();
		
		[CCode (cname ="SDL_HasAltiVec", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_altivec();
		
		[CCode (cname ="SDL_HasMMX", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_mmx();
		
		[CCode (cname ="SDL_HasRDTSC", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_rdtsc();
		
		[CCode (cname ="SDL_HasSSE", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_sse();
		
		[CCode (cname ="SDL_HasSSE2", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_sse2();
		
		[CCode (cname ="SDL_HasSSE3", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_sse3();
		
		[CCode (cname ="SDL_HasSSE41", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_sse41();
		
		[CCode (cname ="SDL_HasSSE42", cheader_filename="SDL2/SDL_cpuinfo.h")]
		public static bool has_sse42();
	}

	[CCode (type_id="SDL_version", cheader_filename="SDL2/SDL_version.h", cname="SDL_version")]
	public class Version {
		public uint8 major;
		public uint8 minor;
		public uint8 patch;

		[CCode (cname="SDL_GetVersion")]
		public static unowned Version get_version();
		
		[CCode (cname="SDL_GetRevision")]
		public static unowned string get_revision();
		
		[CCode (cname="SDL_GetRevisionNumber")]
		public static int get_revision_number();
	}// Version

	///
	/// Hints
	///
	[CCode (cname ="SDL_HintCallback", delegate_target_pos=0, has_target=true, cheader_filename="SDL2/SDL_hints.h")]
	public delegate void HintFunc(string name, string old_value, string? new_value);
	[CCode (cname ="SDL_HintPriority", cheader_filename="SDL2/SDL_hints.h", cprefix="SDL_HINT_" )]
	public enum HintPriority{
	DEFAULT,NORMAL,OVERRIDE
	}
	
	public class Hints{
		[CCode (cname = "\"SDL_ANDROID_APK_EXPANSION_MAIN_FILE_VERSION\"")]
		public const string ANDROID_APK_MAIN_FILE_VERSION;
		
		[CCode (cname = "\"SDL_ANDROID_APK_EXPANSION_PATCH_FILE_VERSION\"")]
		public const string ANDROID_APK_PATCH_FILE_VERSION;
		
		[CCode (cname = "\"SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK\"")]
		public const string MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK;
		
		[CCode (cname = "\"SDL_FRAMEBUFFER_ACCELERATION\"")]
		public const string FRAMEBUFFER_ACCELERATION;
		
		[CCode (cname = "\"SDL_WINDOWS_ENABLE_MESSAGELOOP\"")]
		public const string WINDOWS_ENABLE_MESSAGELOOP;
		
		[CCode (cname = "\"SDL_WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN\"")]
		public const string WINDOW_FRAME_USABLE_WHILE_CURSOR_HIDDEN;
		
		[CCode (cname = "\"SDL_RENDER_DRIVER\"")]
		public const string RENDER_DRIVER;
		
		[CCode (cname = "\"SDL_RENDER_OPENGL_SHADERS\"")]
		public const string RENDER_OPENGL_SHADERS;
		
		[CCode (cname = "\"SDL_RENDER_DIRECT3D_THREADSAFE\"")]
		public const string RENDER_DIRECT3D_THREADSAFE;
		
		[CCode (cname = "\"SDL_RENDER_SCALE_QUALITY\"")]
		public const string RENDER_SCALE_QUALITY;
		
		[CCode (cname = "\"SDL_RENDER_VSYNC\"")]
		public const string RENDER_VSYNC;
		
		[CCode (cname = "\"SDL_VIDEO_ALLOW_SCREENSAVER\"")]
		public const string VIDEO_ALLOW_SCREENSAVER;
		
		[CCode (cname = "\"SDL_VIDEO_HIGHDPI_DISABLED\"")]
		public const string VIDEO_HIGHDPI_DISABLED;
		
		[CCode (cname = "\"SDL_VIDEO_MAC_FULLSCREEN_SPACES\"")]
		public const string VIDEO_MAC_FULLSCREEN_SPACES;
		
		[CCode (cname = "\"SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT\"")]
		public const string VIDEO_WINDOW_SHARE_PIXEL_FORMAT;
		
		[CCode (cname = "\"SDL_VIDEO_WIN_D3DCOMPILER\"")]
		public const string VIDEO_WIN_D3DCOMPILER;
		
		[CCode (cname = "\"SDL_VIDEO_X11_XVIDMODE\"")]
		public const string VIDEO_X11_XVIDMODE;
		
		[CCode (cname = "\"SDL_VIDEO_X11_XINERAMA\"")]
		public const string VIDEO_X11_XINERAMA;
		
		[CCode (cname = "\"SDL_VIDEO_X11_XRANDR\"")]
		public const string VIDEO_X11_XRANDR;
		
		[CCode (cname = "\"SDL_GRAB_KEYBOARD\"")]
		public const string GRAB_KEYBOARD;
		
		[CCode (cname = "\"SDL_IME_INTERNAL_EDITING\"")]
		public const string IME_INTERNAL_EDITING;
		
		[CCode (cname = "\"SDL_MOUSE_RELATIVE_MODE_WARP\"")]
		public const string MOUSE_RELATIVE_MODE_WARP;
		
		[CCode (cname = "\"SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS\"")]
		public const string VIDEO_MINIMIZE_ON_FOCUS_LOSS;
		
		[CCode (cname = "\"SDL_IOS_ORIENTATIONS\"")]
		public const string ORIENTATIONS;
		
		[CCode (cname = "\"SDL_XINPUT_ENABLED\"")]
		public const string XINPUT_ENABLED;
		
		[CCode (cname = "\"SDL_GAMECONTROLLERCONFIG\"")]
		public const string GAMECONTROLLERCONFIG;
		
		[CCode (cname = "\"SDL_ACCELEROMETER_AS_JOYSTICK\"")]
		public const string ACCELEROMETER_AS_JOYSTICK;
		
		[CCode (cname = "\"SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS\"")]
		public const string JOYSTICK_ALLOW_BACKGROUND_EVENTS;
		
		[CCode (cname = "\"SDL_ALLOW_TOPMOST\"")]
		public const string ALLOW_TOPMOST;
		
		[CCode (cname = "\"SDL_TIMER_RESOLUTION\"")]
		public const string TIMER_RESOLUTION;
		
		[CCode (cname = "\"SDL_IDLE_TIMER_DISABLED\"")]
		public const string IDLE_TIMER_DISABLED;
		
		[CCode (cname ="SDL_AddHintCallback", cheader_filename="SDL2/SDL_hints.h")]
		public static void add_callback(string name, HintFunc callback);
		
		[CCode (cname ="SDL_DelHintCallback", cheader_filename="SDL2/SDL_hints.h")]
		public static void del_callback (string name, HintFunc callback);
		
		[CCode (cname ="SDL_SetHint", cheader_filename="SDL2/SDL_hints.h")]
		public static bool set_hint (string name, string hint_value);
		
		[CCode (cname ="SDL_GetHint", cheader_filename="SDL2/SDL_hints.h")]
		public static unowned string get_hint (string name);
		
		//Useful for boolean hints
		public static bool hint_enabled(string name){
			return get_hint(name) == "0" ? true : false;
		}
		
		[CCode (cname ="SDL_ClearHints", cheader_filename="SDL2/SDL_hints.h")]
		public static void clear_all();
		
		[CCode (cname ="SDL_SetHintWithPriority", cheader_filename="SDL2/SDL_hints.h")]
		public static bool set_hint_with_priority(string name, string hint_value, HintPriority priority);
		
	}//Hints
	
	
	///
	/// Power
	///
	[CCode (cname ="SDL_PowerState", cheader_filename="SDL2/SDL_power.h", cprefix="SDL_POWERSTATE_" )]
	public enum PowerState{
		ON_BATTERY, NO_BATTERY, CHARGING,
		CHARGED, UNKNOWN
	}
	[CCode (cname ="SDL_GetPowerInfo", cheader_filename="SDL2/SDL_power.h")]
	public static PowerState get_power_info(out int seconds_left, out int percentage_left);
	//Power
	
	///
	/// Error
	///
	[CCode (cname="SDL_errorcode", cprefix="SDL_")]
	public enum Error {
		ENOMEM, EFREAD, EFWRITE, EFSEEK, 
		UNSUPPORTED, LASTERROR
	}// Error

	[CCode (cname="SDL_SetError")]
	public static int set_error(string format, ...);

	[CCode (cname="SDL_GetError")]
	public static unowned string get_error();

	[CCode (cname="SDL_ClearError")]
	public static void clear_error();

	[CCode (cname="SDL_Error")]
	public static void error(Error code);
	
	///
	/// Video requires
	///
	[CCode (cprefix="SDL_ALPHA_", cheader_filename="SDL2/SDL_pixels.h")]
	public enum Alpha {
		OPAQUE,
		TRANSPARENT
	}// Alpha
	
	[CCode (cprefix="SDL_PIXELTYPE_", cheader_filename="SDL2/SDL_pixels.h")]
	public enum PixelType {
		UNKNOWN,
		INDEX1, INDEX4, INDEX8, PACKED8, PACKED16, PACKED32,
		ARRAYU8, ARRAYU16, ARRAYU32, ARRAYF16, ARRAYF32
	}// PixelType
	
	[CCode (cprefix="SDL_BITMAPORDER", cheader_filename="SDL2/SDL_pixels.h")]
	public enum BitmapOrder {
		[CCode (cname="SDL_BITMAPORDER_NONE")]
		NONE, 
		_4321,  _1234
	}// BitmapOrder
	
	[CCode (cprefix="SDL_PACKEDORDER_", cheader_filename="SDL2/SDL_pixels.h")]
	public enum PackedOrder {
		NONE, XRGB, RGBX, ARGB, RGBA,
		XBGR, BGRX, ABGR, BGRA
	}// PackedOrder
	
	[CCode (cprefix="SDL_ARRAYORDER_", cheader_filename="SDL2/SDL_pixels.h")]
	public enum ArrayOrder {
		NONE, RGB, RGBA,
		ARGB, BGR, BGRA, ABGR
	}// ArrayOrder
	
	[CCode (cprefix="SDL_PACKEDLAYOUT", cheader_filename="SDL2/SDL_pixels.h")]
	public enum PackedLayout {
		[CCode (cname="SDL_PACKEDLAYOUT_NONE")]
		NONE,
		_332, _4444, _1555, _5551,
		_565, _8888, _2101010, _1010102
	}// PackedLayout
	
	[CCode (cname="Uint32", cheader_filename="SDL2/SDL_pixels.h")]
	[Compact]
	public class PixelRAWFormat {
		[CCode (cname="SDL_DEFINE_PIXELFOURCC")]
		public PixelRAWFormat.from_four_cc(char a, char b, char c, char d);

		[CCode (cname="SDL_DEFINE_PIXELFORMAT")]
		public PixelRAWFormat(SDL.PixelType type, SDL.BitmapOrder order, SDL.PackedLayout layout, uchar bits, uchar bytes);

		[CCode (cname="SDL_PIXELFLAG")]
		public uchar get_pixel_flag();

		[CCode (cname="SDL_PIXELTYPE")]
		public SDL.PixelType get_pixel_type();

		[CCode (cname="SDL_PIXELORDER")]
		public SDL.BitmapOrder get_pixel_order();

		[CCode (cname="SDL_PIXELLAYOUT")]
		public SDL.PackedLayout get_pixel_layout();

		[CCode (cname="SDL_BITSPERPIXEL")]
		public uchar bits_per_pixel();

		[CCode (cname="SDL_BYTESPERPIXEL")]
		public uchar bytes_per_pixel();

		[CCode (cname="SDL_ISPIXELFORMAT_INDEXED")]
		public bool is_indexed();

		[CCode (cname="SDL_ISPIXELFORMAT_ALPHA")]
		public bool is_alpha();
		
		[CCode (cname="Uint32", cprefix="SDL_PIXELFORMAT_", cheader_filename="SDL2/SDL_pixels.h")]
		public enum Standards {
			UNKNOWN, INDEX1LSB, INDEX1MSB, INDEX4LSB, INDEX4MSB,
			INDEX8, RGB332, RGB444, RGB555, ARGB4444, RGBA4444,
			ABGR4444, BGRA4444, ARGB1555, RGBA5551, ABGR1555,
			BGRA5551, RGB565, BGR565, RGB24, BGR24, RGB888,
			RGBX8888, BGR888, BGRX8888, ARGB8888, RGBA8888,
			ABGR8888, BGRA8888, ARGB2101010, YV12, IYUV, YUY2,
			UYVY, YVYU
		}// PixelRAWFormat Standards		
	}// PixelFormat
	
	[CCode (cname="SDL_BlendMode", cprefix="SDL_BLENDMODE_")]
	public enum BlendMode {
		NONE, BLEND, ADD, MOD
	}// BlendMode
	
	[CCode (cname="SDL_Point", cheader_filename="SDL2/SDL_rect.h")]
	[SimpleType]
	public struct Point {
		public int x;
		public int y;
	}// Point
	
	[CCode (cname="SDL_BlitMap")]
	[SimpleType]
	public struct BlitMap {
		// Private type, content should not be added
	}// BlitMap
	
	[CCode (cname="SDL_Color", cheader_filename="SDL2/SDL_pixels.h")]
	[SimpleType]
	public struct Color {
		public uint8 r;
		public uint8 g;
		public uint8 b;
		public uint8 a;
	} // Color

	[CCode (cheader_filename="SDL2/SDL_rect.h", cname="SDL_Rect", has_type_id=false)]
	public struct Rect {
		public int x;
		public int y;
		public uint w;
		public uint h;

		public bool is_empty(){
			return(this.w<=0 || this.h<=0);
		}

		[CCode (cname="SDL_RectEquals")]
		public bool is_equal(SDL.Rect other_rect){
			return(this == other_rect ||
			       (this.x==other_rect.x &&
			        this.y==other_rect.y &&
			        this.w==other_rect.w &&
			        this.h==other_rect.h)
			      );
		}
		
		public bool contains (int x, int y) {
			return x >= this.x && this.y >= this.y &&
				x < this.x + this.w && y < this.y + this.h;
		}
		[CCode (cname="SDL_HasIntersection")]
		public bool is_intersecting(SDL.Rect other_rect);

		[CCode (cname="SDL_IntersectRect")]
		public bool intersection_rect(SDL.Rect other_rect, out SDL.Rect result);

		[CCode (cname="SDL_UnionRect")]
		public void union_rect(SDL.Rect other_rect, out SDL.Rect result);

		[CCode (cname="SDL_EnclosePoints")]
		public bool enclose_points(int count, SDL.Rect clip, out SDL.Rect result);

		[CCode (cname="SDL_IntersectRectAndLine")]
		public bool intersects_withline(out int x1, out int y1, out int x2, out int y2);
	}// Rect
	
	
	
	[CCode (type_id="SDL_Palette", cname="SDL_Palette", cheader_filename="SDL2/SDL_pixels.h", cprefix="SDL_", free_function="SDL_FreePalette", ref_function = "SDL_Palette_up", unref_function = "SDL_FreePalette")]
	public class Palette {
		[CCode (array_length_cname = "ncolors", array_length_type = "int")]
		public SDL.Color[] colors;
		public uint32 version;
		public int refcount;
		public unowned Palette up () {
			GLib.AtomicInt.inc(ref this.refcount);
			return this;
		}

		[CCode (cname="SDL_AllocPalette")]
		public Palette(int colors_num);

		[CCode (cname="SDL_SetPaletteColors", array_length_pos=2.1)]
		public int set_colors(SDL.Color[] colors, int first_color);
	}
	
	[CCode (type_id="SDL_PixelFormat", cname="SDL_PixelFormat", cheader_filename="SDL2/SDL_pixels.h", cprefix="SDL_", free_function="SDL_FreeFormat", ref_function = "SDL_PixelFormat_up", unref_function = "SDL_FreeFormat")]
	public class PixelFormat {
		public SDL.PixelRAWFormat format;
		public SDL.Palette palette;
		[CCode ( cname="BitsPerPixel")]
		public uint8 bits_per_pixel;
		[CCode ( cname="BytesPerPixel")]
		public uint8 bytes_per_pixel;
		//public uint8 padding[2]; Is this even useful? We are binding a Struct, not recreating one
		[CCode ( cname="Rmask")]
		public uint32 r_mask;
		[CCode ( cname="Gmask")]
		public uint32 g_mask;
		[CCode ( cname="Bmask")]
		public uint32 b_mask;
		[CCode ( cname="Amask")]
		public uint32 a_mask;
		public uint8 r_loss;
		public uint8 g_loss;
		public uint8 b_loss;
		public uint8 a_loss;
		public uint8 r_shift;
		public uint8 g_shift;
		public uint8 b_shift;
		public uint8 a_shift;
		
		public int refcount;
		public SDL.PixelFormat next;
		
		public unowned PixelFormat up () {
			GLib.AtomicInt.inc(ref this.refcount);
			return this;
		}
		
		[CCode (cname="SDL_AllocFormat")]
		public PixelFormat(uint32 pixel_format);

		[CCode (cname="SDL_SetPixelFormatPalette")]
		public int set_palette(SDL.Palette palette);

		[CCode (cname="SDL_MapRGB")]
		public uint32 map_rgb(uint8 r, uint8 g, uint8 b);

		[CCode (cname="SDL_MapRGBA")]
		public uint32 map_rgba(uint8 r, uint8 g, uint8 b, uint8 a);

		[CCode (cname="SDL_GetRGB", instance_pos=1.2)]
		public void get_rgb(uint32 pixel, ref uint8 r, ref uint8 g, ref uint8 b);

		[CCode (cname="SDL_GetRGBA", instance_pos=1.2)]
		public void get_rgba(uint32 pixel, ref uint8 r, ref uint8 g, ref uint8 b, ref uint8 a);
		
		[CCode (cname="SDL_CalculateGammaRamp")]
		public static void calc_gamma_ramp(float gamma, out uint16 ramp);
		
		[CCode (cname="SDL_GetPixelFormatName")]
		public static unowned string? get_pixelformatname(SDL.PixelRAWFormat format);
		
		[CCode (cname="SDL_PixelFormatEnumToMasks")]
		public static bool enum_tomasks(SDL.PixelRAWFormat format,
			out int bpp, out uint32 r_mask, out uint32 g_mask, out uint32 b_mask, out uint32 a_mask);
		
		[CCode (cname="SDL_MasksToPixelFormatEnum")]
		public static uint32 masks_toenum(
			int bpp, uint32 r_mask, uint32 g_mask, uint32 b_mask, uint32 a_mask);
	}// PixelFormat

	[CCode (cname="SDL_blit", cheader_filename="SDL2/SDL_surface.h")]
	public delegate int BlitFunc (SDL.Surface src, SDL.Rect? srcrect,
	  SDL.Surface dst, SDL.Rect? dstrect);

	[CCode (type_id="SDL_Surface", cname="SDL_Surface", free_function="SDL_FreeSurface", cheader_filename="SDL2/SDL_surface.h", ref_function = "SDL_Surface_up", unref_function = "SDL_FreeSurface")]
	public class Surface {
		public uint32 flags;
		public SDL.PixelFormat format;
		public int w;
		public int h;
		public int pitch;
		public void *pixels;
		public void *userdata;
		public int locked;
		public void *lock_data;
		public SDL.Rect clip_rect;
		public SDL.BlitMap map;
		public int refcount;
		
		public unowned Surface up () {
			GLib.AtomicInt.inc(ref this.refcount);
			return this;
		}

		[CCode (cname="SDL_CreateRGBSurface")]
		public Surface.rgb(uint32 flags, int width, int height, int depth,
					uint32 rmask, uint32 gmask, uint32 bmask, uint32 amask);

		[CCode (cname="SDL_CreateRGBSurfaceFrom")]
		public Surface.from_rgb(void* pixels, int width, int height, int depth, 
			int pitch, uint32 rmask, uint32 gmask, uint32 bmask, uint32 amask);

		[CCode (cname="SDL_LoadBMP_RW")]
		public Surface.from_bmp_rw(SDL.RWops src, int freesrc=0);

		[CCode (cname="SDL_LoadBMP")]
		public Surface.from_bmp(string file);

		[CCode (cname="SDL_SetSurfacePalette")]
		public int set_palette (SDL.Palette palette);

		[CCode(cname= "SDL_MUSTLOCK")]
		public bool must_lock();
		
		[CCode (cname="SDL_LockSurface")]
		public int do_lock();

		[CCode (cname="SDL_UnlockSurface")]
		public void unlock();

		[CCode (cname="SDL_SaveBMP_RW")]
		public int save_bmp_rw(RWops dst, int freedst=0);

		public int save_bmp(string file){
			return save_bmp_rw(new SDL.RWops.from_file(file, "wb"), 1);
		}

		[CCode (cname="SDL_SetSurfaceRLE")]
		public int set_rle(int flag);

		[CCode (cname="SDL_SetColorKey")]
		public int set_colorkey(int flag, uint32 key);

		[CCode (cname="SDL_GetColorKey")]
		public int get_colorkey(out uint32 key);

		[CCode (cname="SDL_SetSurfaceColorMod")]
		public int set_colormod(uint8 r, uint8 g, uint8 b);

		[CCode (cname="SDL_GetSurfaceColorMod")]
		public int get_colormod(out uint8 r, out int8 g, out uint8 b);

		[CCode (cname="SDL_SetSurfaceAlphaMod")]
		public int set_alphamod(uint8 alpha);

		[CCode (cname="SDL_GetSurfaceAlphaMod")]
		public int get_alphamod(out uint8 alpha);

		[CCode (cname="SDL_SetSurfaceBlendMode")]
		public int set_blendmode(SDL.BlendMode blend_mode);

		[CCode (cname="SDL_GetSurfaceBlendMode")]
		public int get_blendmode(out SDL.BlendMode blend_mode);

		[CCode (cname="SDL_SetClipRect")]
		public bool set_cliprect(SDL.Rect? rect);

		[CCode (cname="SDL_GetClipRect")]
		public int get_cliprect(out SDL.Rect rect);

		[CCode (cname="SDL_ConvertSurface")]
		public Surface? convert(SDL.PixelFormat? fmt, uint32 flags);

		[CCode (cname="SDL_ConvertSurfaceFormat")]
		public Surface? convert_format(uint32 pixel_fmt, uint32 flags);

		[CCode (cname="SDL_ConvertPixels")]
		public static int convert_pixels(int width, int height,
  SDL.PixelRAWFormat.Standards src_format,
  void *src, int src_pitch,
  SDL.PixelRAWFormat.Standards dst_format,
  void * dst, int dst_pitch);
		
		[CCode (cname="SDL_FillRect")]
		public int fill_rect(SDL.Rect? rect, uint32 color);
		
		[CCode (cname="SDL_FillRects")]
		public int fill_rects(SDL.Rect[] rects, uint32 color);

		[CCode (cname="SDL_BlitSurface")]
		public int blit(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_LowerBlit")]
		public int lowerblit(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_BlitScaled")]
		public int blit_scaled(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_LowerBlitScaled")]
		public int lowerblit_scaled(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);

		[CCode (cname="SDL_SoftStretch")]
		public int softstretch(SDL.Rect? srcrect, SDL.Surface dst, SDL.Rect? dstrect);
	} //Surface


	///
	/// Video
	///
	
	[CCode (cname="SDL_DisplayMode", destroy_function="", cheader_filename="SDL2/SDL_video.h")]
	public struct DisplayMode {
		public SDL.PixelRAWFormat format;
		public int w;
		public int h;
		public int refresh_rate;
		public void *driverdata; //Please, initialize as NULL
	}// DisplayMode

	[Flags, CCode (cname="SDL_WindowFlags", cprefix="SDL_WINDOW_", cheader_filename="SDL2/SDL_video.h")]
	public enum WindowFlags {
		FULLSCREEN, OPENGL, SHOWN, HIDDEN, BORDERLESS, RESIZABLE,
		MINIMIZED, MAXIMIZED, INPUT_GRABBED, INPUT_FOCUS, MOUSE_FOCUS,
		FULLSCREEN_DESKTOP, FOREIGN, ALLOW_HIGHDPI, MOUSE_CAPTURE
	}// WindowFlags

	[Flags, CCode (cname="SDL_WindowEventID", cprefix="SDL_WINDOWEVENT_", cheader_filename="SDL2/SDL_video.h")]
	public enum WindowEventID {
		NONE, SHOWN, HIDDEN, EXPOSED, MOVED, RESIZED,
		SIZE_CHANGED, MINIMIZED, MAXIMIZED, RESTORED,
		ENTER, LEAVE, FOCUS_GAINED, FOCUS_LOST, CLOSE
	}// WindowEventID

	
	[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL_video.h")]
	[Compact]
	public class Video {
		[CCode (cname="SDL_GetNumVideoDrivers")]
		public static int num_drivers();
		
		[CCode (cname="SDL_GetVideoDriver")]
		public static unowned string? get_driver(int driver_index);
		
		[CCode (cname="SDL_VideoInit")]
		public static int init(string driver_name);
		
		[CCode (cname="SDL_VideoQuit")]
		public static void quit();
		
		[CCode (cname="SDL_GetCurrentVideoDriver")]
		public static unowned string? get_current_driver();
		
		[CCode (cname="SDL_GetNumVideoDisplays")]
		public static int num_displays();
		
		[CCode (cname="SDL_IsScreenSaverEnabled")]
		public static bool is_screensaver_enabled();
		
		[CCode (cname="SDL_EnableScreenSaver")]
		public static void enable_screensaver();
		
		[CCode (cname="SDL_DisableScreenSaver")]
		public static void disable_screensaver();
	}// Video
	
	[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL_video.h")]
	[Compact]
	public class Display { //Considering to put it out class Video
		[CCode (cname="SDL_GetDisplayName")]
		public static unowned string? get_name(int index);
		
		[CCode (cname="SDL_GetDisplayBounds")]
		public static int get_bounds(int index, out SDL.Rect rect);
		
		[CCode (cname="SDL_GetNumDisplayModes")]
		public static int num_modes(int index);
		
		[CCode (cname="SDL_GetDisplayMode")]
		public static int get_mode(int dysplay_index, int mode_index, out SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetDesktopDisplayMode")]
		public static int get_desktop_mode(int index, out SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetCurrentDisplayMode")]
		public static int get_current_mode(int index, out SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetClosestDisplayMode")]
		public static SDL.DisplayMode get_closest_mode(int index, SDL.DisplayMode mode, out SDL.DisplayMode closest);
	}// Display
	
	[CCode (cname=" SDL_SYSWM_TYPE", cprefix="SDL_SYSWM_", cheader_filename="SDL2/SDL_syswm.h")]
	public enum SysWMType{
		UNKNOWN,WINDOWS,X11,DIRECTFB,COCOA,UIKIT;
	}
	[CCode (cname="SDL_SysWMmsg", cheader_filename="SDL2/SDL_syswm.h")]
	public struct SysWMmsg {
		[CCode (cname="msg.dummy")]
		int msg;
		SysWMType type;
		SDL.Version version;		
	}// SysWMmsg
	
	[CCode (cname="SDL_SysWMinfo", cheader_filename="SDL2/SDL_syswm.h")]
	public struct SysWMInfo {
		[CCode (cname="info.dummy")]
		int info;
		SysWMType type;
		SDL.Version version;		
	}// SysWMmsg
	
	[CCode (cname=" SDL_HitTestResult", cprefix="SDL_HITTEST_", cheader_filename="SDL2/SDL_video.h")]
	public enum HitTestResult{
		NORMAL, DRAGGABLE, RESIZE_TOPLEFT, RESIZE_TOP, RESIZE_TOPRIGHT, 
		RESIZE_RIGHT, RESIZE_BOTTOMRIGHT, RESIZE_BOTTOM, RESIZE_BOTTOMLEFT,
		RESIZE_LEFT;
	}
	
	[CCode (cname = "SDL_HitTest", has_target= true, delegate_target_pos = 1.1)]
	public delegate HitTestResult HitTestFunc(Window window, ref SDL.Point area);
	
	
	[CCode (cprefix="SDL_", cname = "SDL_Window", destroy_function = "SDL_DestroyWindow", cheader_filename="SDL2/SDL_video.h")]
	[Compact]
	public class Window {
		[CCode (cname="SDL_WINDOWPOS_UNDEFINED_MASK")]
		public static const uint8 POS_UNDEFINED;
		
		[CCode (cname="SDL_WINDOWPOS_CENTERED_MASK")]
		public static const uint8 POS_CENTERED;
		
		[CCode (cname="SDL_CreateWindow")]
		public Window(string title, int x, int y, int w, int h, uint32 flags);
		
		// Param data is a "pointer to driver-dependent window creation data"
		[CCode (cname="SDL_CreateWindowFrom")]
		public Window.from_native(void *data);
		
		[CCode (cname="SDL_GetWindowFromID")]
		public Window.from_id(uint32 id);
		
		[CCode (cname="SDL_GetWindowDisplayIndex")]
		public int get_display();
		
		[CCode (cname="SDL_SetWindowDisplayMode")]
		public int set_display_mode(SDL.DisplayMode mode);
		
		[CCode (cname="SDL_GetWindowDisplayMode")]
		public int get_display_mode(out SDL.DisplayMode mode);
		
		[CCode (cname="SDL_SetWindowHitTest")]
		public int set_hit_test(HitTestFunc callback);
		
		[CCode (cname="SDL_GetWindowPixelFormat")]
		public uint32 get_pixelformat();
		
		[CCode (cname="SDL_GetWindowID")]
		public uint32 get_id();
		
		[CCode (cname="SDL_GetWindowFlags")]
		public uint32 get_flags();
		
		public string title{
			[CCode (cname="SDL_GetWindowTitle")]get;
			[CCode (cname="SDL_SetWindowTitle")]set;
		}
		
		[CCode (cname="SDL_SetWindowIcon")]
		public void set_icon(SDL.Surface icon);
		
		[CCode (cname="SDL_SetWindowData")]
		public void set_data(string name, void *usrdata);
		
		[CCode (cname="SDL_GetWindowData")]
		public void get_data(string name);
		
		[CCode (cname="SDL_SetWindowPosition")]
		public void set_position(int x, int y);
		
		[CCode (cname="SDL_GetWindowPosition")]
		public void get_position(out int x, out int y); //TODO: create a beautilful method
		
		[CCode (cname="SDL_SetWindowSize")]
		public void set_size(int w, int h);
		
		[CCode (cname="SDL_GetWindowSize")]
		public void get_size(out int w, out int x); //TODO: create a beautilful method
		
		[CCode (cname="SDL_SetWindowMinimumSize")]
		public void set_minsize(int w, int h);
		
		[CCode (cname="SDL_GetWindowMinimumSize")]
		public void get_minsize(out int w, out int x); //TODO: create a beautilful method
		
		[CCode (cname="SDL_SetWindowMaximumSize")]
		public void set_maxsize(int w, int h);
		
		[CCode (cname="SDL_GetWindowMaximumSize")]
		public void get_maxsize(out int w, out int x); //TODO: create a beautilful method
		
		[CCode (cname="SDL_SetWindowBordered")]
		public void set_bordered(bool bordered);
		
		[CCode (cname="SDL_ShowWindow")]
		public void show();
		
		[CCode (cname="SDL_HideWindow")]
		public void hide();
		
		[CCode (cname="SDL_RaiseWindow")]
		public void raise();
		
		[CCode (cname="SDL_MaximizeWindow")]
		public void maximize();
		
		[CCode (cname="SDL_MinimizeWindow")]
		public void minimize();
		
		[CCode (cname="SDL_RestoreWindow")]
		public void restore();
		
		[CCode (cname="SDL_SetWindowFullscreen")]
		public int set_fullscreen(uint32 flags);
		
		[CCode (cname="SDL_GetWindowSurface")]
		public SDL.Surface get_surface();
		
		[CCode (cname="SDL_UpdateWindowSurface")]
		public int update_surface();
		
		[CCode (cname="SDL_UpdateWindowSurfaceRects")]
		public int update_surface_rects(SDL.Rect[] rects);
		
		public bool grab{
			[CCode (cname="SDL_GetWindowGrab")]get;
			[CCode (cname="SDL_SetWindowGrab")]set;
		}
			
		[CCode (cname="SDL_SetWindowBrightness")]
		public int set_brightness(float brightness);
		
		[CCode (cname="SDL_GetWindowBrightness")]
		public float get_brightness();
		
		[CCode (cname="SDL_SetWindowGammaRamp")]
		public int set_gammaramp(uint16[]? red, uint16[]? green, uint16[]? blue);
		
		[CCode (cname="SDL_GetWindowGammaRamp")]
		public int get_gammaramp(out uint16[]? red,out uint16[]? green, out uint16[]? blue);
		
		[CCode (cname="SDL_GetWindowWMInfo", cheader_filename="SDL2/SDL_syswm.h")]
		public bool get_wm_info(out SysWMInfo info);
		
		[CCode (cname="SDL_DestroyWindow")]
		public void destroy();
	}//Window
	
	///
	/// OpenGL
	///
	[CCode (cprefix="SDL_GL_", cheader_filename="SDL2/SDL_video.h")]	
	namespace GL {
	
		[CCode (type_id="SDL_GLContext", cname="SDL_GLContext", destroy_function="SDL_GL_DeleteContext", cheader_filename="SDL2/SDL_video.h")]
		public class Context{
			[CCode (cname="SDL_GL_CreateContext")]
			public Context(SDL.Window window);
		}// GLContext
		
		[CCode (cname="SDL_GLattr", cprefix="SDL_GL_", cheader_filename="SDL2/SDL_video.h")]
		public enum Attributes{
			RED_SIZE, GREEN_SIZE, BLUE_SIZE, ALPHA_SIZE, 
			BUFFER_SIZE, DOUBLEBUFFER, DEPTH_SIZE, STENCIL_SIZE, 
			ACCUM_RED_SIZE, ACCUM_GREEN_SIZE, ACCUM_BLUE_SIZE, 
			ACCUM_ALPHA_SIZE, STEREO, MULTISAMPLEBUFFERS, 
			MULTISAMPLESAMPLES, ACCELERATED_VISUAL, RETAINED_BACKING,
			CONTEXT_MAJOR_VERSION, CONTEXT_MINOR_VERSION,
			CONTEXT_EGL, CONTEXT_FLAGS, CONTEXT_PROFILE_MASK,
			SHARE_WITH_CURRENT_CONTEXT, FRAMEBUFFER_SRGB_CAPABLE,
			CONTEXT_RELEASE_BEHAVIOR
		}// GLattr
		
		[CCode (cname="SDL_GLprofile", cprefix="SDL_GL_CONTEXT_PROFILE_", cheader_filename="SDL2/SDL_video.h")]
		public enum ProfileType{
			CORE, COMPATIBILITY, ES;
		}// GLprofile
		
		[CCode (cname="SDL_GLcontextFlag", cprefix="SDL_GL_CONTEXT_", lower_case_csuffix="flag", cheader_filename="SDL2/SDL_video.h")]
		public enum ContextFlag{
			DEBUG, FORWARD_COMPATIBLE, ROBUST_ACCESS, RESET_ISOLATION
		}
		[CCode (cname="SDL_GL_LoadLibrary")]
		public static int load_library(string path);

		[CCode (cname="SDL_GL_GetProcAddress")]
		public static void* get_proc_address(string proc);
		
		[CCode (cname="SDL_GL_UnloadLibrary")]
		public static void unload_lbrary();
		
		[CCode (cname="SDL_GL_ExtensionSupported")]
		public static bool is_extension_supported(string extension);
		
		[CCode (cname="SDL_GL_ResetAttributes")]
		public static void reset_attribute();

		[CCode (cname="SDL_GL_SetAttribute")]
		public static int set_attribute(SDL.GL.Attributes attr, int val);

		[CCode (cname="SDL_GL_GetAttribute")]
		public static int get_attribute(SDL.GL.Attributes attr, out int val);

		[CCode (cname="SDL_GL_MakeCurrent")]
		public static int make_current(SDL.Window window, SDL.GL.Context context);

		[CCode (cname="SDL_GL_SetSwapInterval")]
		public static int set_swapinterval(int interval);

		[CCode (cname="SDL_GL_GetSwapInterval")]
		public static int get_swapinterval();

		[CCode (cname="SDL_GL_SwapWindow")]
		public static void swap_window(SDL.Window window);

		
	}// GL
	
	///
	/// MessageBox
	///
	[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL_messagebox.h")]
	namespace MessageBox{
		[Flags, CCode (cname="SDL_MessageBoxFlags", cprefix="SDL_MESSAGEBOX_", cheader_filename="SDL2/SDL_messagebox.h")]
		public enum Flags {
			/**
			 * error dialog
			 */
			ERROR,
			/**
			 * warning dialog
			 */
			WARNING,
			/**
			 * informational dialog
			 */
			INFORMATION
		} // MessageBoxFlags;
		[Flags, CCode (cname="SDL_MessageBoxButtonFlags", cprefix="SDL_MESSAGEBOX_BUTTON_", cheader_filename="SDL2/SDL_messagebox.h")]
		public enum ButtonFlags{
		/**
		 * Marks the default button when return is hit
		 */
		RETURNKEY_DEFAULT,
		/**
		 * Marks the default button when escape is hit
		 */
		ESCAPEKEY_DEFAULT
		} //MessageBoxButtonFlags;
		[CCode (cname="SDL_MessageBoxColorType", cprefix="SDL_MESSAGEBOX_COLOR_", cheader_filename="SDL2/SDL_messagebox.h")]
		public enum ColorType{
		BACKGROUND,
		TEXT,
		BUTTON_BORDER,
		BUTTON_BACKGROUND,
		BUTTON_SELECTED,
		MAX
		} //MessageBoxColorType;
		[CCode (cname="SDL_MessageBoxButtonData", destroy_function="", cheader_filename="SDL2/SDL_messagebox.h")]
		public struct ButtonData{
		/**
		 * ::SDL_MessageBoxButtonFlags
		 */
		MessageBox.ButtonFlags flags;
		int buttonid;   /**< User defined button id (value returned via SDL_ShowMessageBox) */
		/**
		 * The UTF-8 button text
		 */
		string text;
		} //MessageBoxButtonData;
		[CCode (cname="SDL_MessageBoxColor", destroy_function="", cheader_filename="SDL2/SDL_messagebox.h")]
		public struct Color{
		uint8 r;
		uint8 g;
		uint8 b;
		} // MessageBoxColor;
		[CCode (cname="SDL_MessageBoxColorScheme", destroy_function="", cheader_filename="SDL2/SDL_messagebox.h")]
		public struct ColorScheme{
			[CCode (array_length_cname="SDL_MessageBoxColorType.MAX", array_length_type="int")]
			SDL.MessageBox.Color colors [];
		} // MessageBoxColorScheme;

		[CCode (cname="SDL_MessageBoxData", destroy_function="", cheader_filename="SDL2/SDL_messagebox.h")]
		public struct Data {
		MessageBox.Flags flags;   /**< ::SDL_MessageBoxFlags */
		/**
		 * Parent window, can be null
		 */
		[CCode (cname="window")]
		SDL.Window? parent_window;
		string title;  /**< UTF-8 title */
		/**
		 * UTF-8 message text
		 */
		string message;
		[CCode (array_length_cname = "numbuttons", array_length_type = "int")]
		SDL.MessageBox.ButtonData[] buttons;
		/**
		 * ::SDL_MessageBoxColorScheme, can be NULL to use system settings
		 */
		[CCode (cname="colorScheme")]
		SDL.MessageBox.ColorScheme? color_scheme;
		} //MessageBoxData;
		
		[CCode (cname="SDL_ShowSimpleMessageBox")]
		public static int simple_show(MessageBox.Flags flags, string title, string message, SDL.Window? parent = null);

		[CCode (cname="SDL_ShowMessageBox")]
		public static int show(MessageBox.Data data, int buttonid);
	
	}// MessageBox
	
	
	///
	/// RWops
	///
	
	[Flags, CCode (cname="int", cprefix="RW_SEEK_", cheader_filename="SDL2/SDL_rwops.h")]
	public enum RWFlags {
		SET,CUR,END
	}// RWFlags
	
	[CCode (cname="SDL_RWops", free_function="SDL_FreeRW", cheader_filename="SDL2/SDL_rwops.h")]
	
	[Compact]
	public class RWops {
		
		public uint32 type;
		
		[CCode (cname="SDL_RWread")]
		public size_t read(void* ptr, size_t size,size_t maxnum);
		
		[CCode (cname="SDL_RWwrite")]
		public size_t write(void* ptr, size_t size,size_t num);
		
		[CCode (cname="SDL_RWseek")]
		public int64 seek(int64 offset, SDL.RWFlags flag);
		
		[CCode (cname="SDL_RWtell")]
		public int64 tell();

		[CCode (cname="SDL_RWclose")]
		public int64 close();
		
		[CCode (cname="SDL_RWFromFile")]
		public RWops.from_file(string file, string mode);

		[CCode (cname="SDL_RWFromMem")]
		public RWops.from_mem(void* mem, int size);
		
		
	}// RWops
	
	///
	/// Events
	///
	[CCode (cname="SDL_EventType", cprefix="SDL_", cheader_filename="SDL2/SDL_events.h")]
	public enum EventType {
		// TODO: Review if updated
		FIRSTEVENT,QUIT,APP_TERMINATING,APP_LOWMEMORY,APP_WILLENTERBACKGROUND,APP_DIDENTERBACKGROUND,
		APP_WILLENTERFOREGROUND, APP_DIDENTERFOREGROUND,WINDOWEVENT,SYSWMEVENT,KEYDOWN,KEYUP,TEXTEDITING,
		TEXTINPUT,MOUSEMOTION,MOUSEBUTTONDOWN,MOUSEBUTTONUP,MOUSEWHEEL,JOYAXISMOTION,JOYBALLMOTION, 
		JOYHATMOTION,JOYBUTTONDOWN,JOYBUTTONUP,JOYDEVICEADDED,JOYDEVICEREMOVED,CONTROLLERAXISMOTION,
		CONTROLLERBUTTONDOWN,CONTROLLERBUTTONUP,CONTROLLERDEVICEADDED,CONTROLLERDEVICEREMOVED,
		CONTROLLERDEVICEREMAPPED,FINGERDOWN,FINGERUP,FINGERMOTION,DOLLARGESTURE,DOLLARRECORD,MULTIGESTURE,
		CLIPBOARDUPDATE,DROPFILE,AUDIODEVICEADDED,AUDIODEVICEREMOVED,RENDER_TARGETS_RESET,RENDER_DEVICE_RESET,
		USEREVENT,LASTEVENT;
	}// EventType
	
	[CCode (cname="SDL_CommonEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct CommonEvent {
		SDL.EventType type;
		uint32 timestamp;
	}// CommonEvent
	
	[CCode (cname="SDL_WindowEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct WindowEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		uint8 event;
		uint8 padding1;
		uint8 padding2;
		uint8 padding3;
		int32 data1;
		int32 data2;
	}// WindowEvent
	
	[CCode (cname="SDL_AudioDeviceEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct AudioDeviceEvent : CommonEvent{
			uint32 which;
			bool iscapture;
   } 
	
	[CCode (cname="SDL_KeyboardEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct KeyboardEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		uint8 state;
		uint8 repeat;
		uint8 padding2;
		uint8 padding3;
		SDL.Key keysym;
	}// KeyboardEvent
	
	[CCode (cname="SDL_TextEditingEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct TextEditingEvent : CommonEvent {
		[CCode (cname="SDL_TEXTEDITINGEVENT_TEXT_SIZE")]
		public static const uint8 TEXT_SIZE;
		
		[CCode (cname="windowID")] uint32 window_id;
		string? text;
		int32 start;
		int32 length;
	}// TextEditingEvent
	
	[CCode (cname="SDL_TextInputEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct TextInputEvent : CommonEvent {
		[CCode (cname="SDL_TEXTINPUTEVENT_TEXT_SIZE")]
		public static const uint8 TEXT_SIZE;
		
		[CCode (cname="windowID")] uint32 window_id;
		string? text;
	}// TextInputEvent
	
	[CCode (cname="SDL_MouseMotionEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct MouseMotionEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		uint32 which;
		uint8 state;
		int32 x;
		int32 y;
		int32 xrel;
		int32 yrel;
	}// MouseMotionEvent
	
	[CCode (cname="SDL_MouseButtonEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct MouseButtonEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		uint32 which;
		uint8 button;
		uint8 state;
		uint8 clicks;
		uint8 padding1;
		int32 x;
		int32 y;
	}// MouseButtonEvent
	
	[CCode (cname="SDL_MouseWheelEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct MouseWheelEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		uint32 which;
		int32 x;
		int32 y;
	}// MouseWheelEvent
	
	[CCode (cname="SDL_JoyAxisEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyAxisEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		SDL.JoystickID which;
		uint8 axis;
		int16 @value;
	}// JoyAxisEvent
	
	[CCode (cname="SDL_JoyBallEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyBallEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		SDL.JoystickID which;
		uint8 ball;
		int16 xrel;
		int16 yrel;
	}// JoyBallEvent
	
	[CCode (cname="Uint8", cprefix="SDL_HAT_", cheader_filename="SDL2/SDL_events.h")]
	public enum HatValue {
		LEFTU, UP, RIGHTUP,
		LEFT, CENTERED, RIGHT,
		LEFTDOWN, DOWN, RIGHTDOWN
	}
	
	[CCode (cname="SDL_JoyHatEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyHatEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		SDL.JoystickID which;
		uint8 hat;
		SDL.HatValue hat_value;
	}// JoyHatEvent
	
	[CCode (cname="SDL_JoyButtonEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyButtonEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		SDL.JoystickID which;
		uint8 button;
		uint8 state;
	}// JoyButtonEvent
	
	[CCode (cname="SDL_JoyDeviceEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct JoyDeviceEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		SDL.JoystickID which;
	}// JoyDeviceEvent
	
	[CCode (cname="SDL_ControllerAxisEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerAxisEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		SDL.JoystickID which;
		uint8 axis;
		int16 @value;

	}// ControllerAxisEvent
	
	[CCode (cname="SDL_ControllerButtonEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerButtonEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		SDL.JoystickID which;
		uint8 button;
		uint8 state;
	}// ControllerButtonEvent
	
	[CCode (cname="SDL_ControllerDeviceEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct ControllerDeviceEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		SDL.JoystickID which;
	}// ControllerDeviceEvent
	
	[CCode (cname="SDL_TouchFingerEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct TouchFingerEvent : CommonEvent {
		[CCode (cname="touchID")]
		SDL.Touch.TouchID touch_id;
		[CCode (cname="fingerID")]
		SDL.Touch.FingerID finger_id;
		float x;
		float y;
		float dx;
		float dy;
		float pressure;
	}// TouchFingerEvent
	
	[CCode (cname="SDL_MultiGestureEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct MultiGestureEvent : CommonEvent {
		[CCode (cname="touchID")]
		SDL.Touch.TouchID touch_id;
		[CCode (cname="dTheta")]
		float d_theta;
		[CCode (cname="dDist")]
		float d_dist;
		float x;
		float y;
		float pressure;
		[CCode (cname="numFingers")]
		uint16 num_fingers;
	}// MultiGestureEvent
	
	[CCode (cname="SDL_DollarGestureEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct DollarGestureEvent : CommonEvent {
		[CCode (cname="touchID")]
		SDL.Touch.TouchID touch_id;
		[CCode (cname="gestureID")]
		SDL.Gesture.GestureID gesture_id;
		[CCode (cname="numFingers")]
		uint32 num_fingers;
		float error;
		float x;
		float y;
	}// DollarGestureEvent
	
	[CCode (cname="SDL_DropEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct DropEvent : CommonEvent {
		string file;
	}// DropEvent
	
	[CCode (cname="SDL_UserEvent", has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct UserEvent : CommonEvent {
		[CCode (cname="windowID")] uint32 window_id;
		int32 code;
		void* data1;
		void* data2;
	}// UserEvent
	
	[CCode (cname="SDL_QuitEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct QuitEvent : CommonEvent {}// QuitEvent
	
	
	[CCode (cname="SDL_OSEvent",  has_type_id=false, cheader_filename="SDL2/SDL_events.h")]
	[Compact]
	public struct OSEvent : CommonEvent {}// OSEvent

	[CCode (cname="SDL_SysWMEvent", type_id="SDL_SysWMEvent", cheader_filename="SDL2/SDL_events.h")]
	public struct SysWMEvent {
		public SysWMmsg msg;
	}// SysWMEvent
	
	[CCode (has_target = true)]
	public delegate int EventFilter (SDL.Event ev);
	
	[CCode (cname="SDL_Event", has_type_id=false, has_target=false, destroy_function="", cheader_filename="SDL2/SDL_events.h")]
	[SimpleType]
	public struct Event {
		public SDL.EventType type;
		public SDL.CommonEvent generic;
		public SDL.WindowEvent window;
		public SDL.KeyboardEvent key;
		public SDL.TextEditingEvent edit;
		public SDL.TextInputEvent text;
		public SDL.MouseMotionEvent motion;
		public SDL.MouseButtonEvent button;
		public SDL.MouseWheelEvent wheel; 
		public SDL.JoyAxisEvent jaxis;
		public SDL.JoyBallEvent jball;
		public SDL.JoyHatEvent jhat;
		public SDL.JoyButtonEvent jbutton;
		public SDL.JoyDeviceEvent jdevice;
		public SDL.ControllerAxisEvent caxis;
		public SDL.ControllerButtonEvent cbutton;
		public SDL.ControllerDeviceEvent cdevice;
		public SDL.AudioDeviceEvent adevice;
		public SDL.QuitEvent quit; 
		public SDL.UserEvent user;
		public SDL.SysWMEvent syswm;
		public SDL.TouchFingerEvent tfinger;
		public SDL.MultiGestureEvent mgesture;
		public SDL.DollarGestureEvent dgesture;
		public SDL.DropEvent drop;
		
		[CCode (cname="SDL_PumpEvents")]
		public static void pump();

		[CCode (cname="SDL_PeepEvents")]
		public static void peep(SDL.Event[] events,	EventAction action, 
			uint32 min_type, uint32 max_type);

		[CCode (cname="SDL_HasEvent")]
		public static bool has_event(SDL.EventType type);

		[CCode (cname="SDL_HasEvents")]
		public static bool has_events(uint32 min_type, uint32 max_type);

		[CCode (cname="SDL_FlushEvent")]
		public static void flush_event(SDL.EventType type);

		[CCode (cname="SDL_FlushEvents")]
		public static void flush_events(uint32 min_type, uint32 max_type);

		[CCode (cname="SDL_PollEvent")]
		public static int poll(out SDL.Event ev);

		[CCode (cname="SDL_WaitEvent")]
		public static int wait(out SDL.Event ev);

		[CCode (cname="SDL_WaitEventTimeout")]
		public static int wait_inms(out SDL.Event ev, int timeout);

		[CCode (cname="SDL_PushEvent")]
		public static int push(SDL.Event ev);
		
		[CCode (cname="SDL_SetEventFilter")]
		public static void set_eventfilter(SDL.EventFilter filter);

		[CCode (cname="SDL_GetEventFilter")]
		public static bool get_eventfilter(out SDL.EventFilter filter);

		[CCode (cname="SDL_AddEventWatch")]
		public static void add_eventwatch(SDL.EventFilter filter);

		[CCode (cname="SDL_DelEventWatch")]
		public static void del_eventwatch(SDL.EventFilter filter);

		[CCode (cname="SDL_FilterEvents")]
		public static void filter_events(SDL.EventFilter filter);

		[CCode (cname="SDL_EventState")]
		public static uint8 state(SDL.EventType type, SDL.EventState state);

		[CCode (cname="SDL_RegisterEvents")]
		public static uint32 register_events(int numevents);
		
		[CCode (cname="SDL_QuitRequested")]
		public static bool quit_requested();

		
	}// Event
	[CCode (cheader_filename="SDL2/SDL_gesture.h")]	
	namespace Gesture{
		[CCode (cname="SDL_GestureID", cheader_filename="SDL2/SDL_gesture.h")]
		public struct GestureID : int {}// GestureID
	
		[CCode (cname="SDL_RecordGesture")]
		public static int record_gesture(Touch.TouchID touch_id);
		
		[CCode (cname="SDL_LoadDollarTemplate")]
		public static int load_dollar_template_rw(Touch.TouchID touch_id, SDL.RWops src);

		public static int load_dollar_template(Touch.TouchID touch_id, string file){
			return load_dollar_template_rw(touch_id,new SDL.RWops.from_file(file, "rb"));
		}
		
		[CCode (cname="SDL_SaveDollarTemplate")]
		public static bool save_dollar_template_rw(GestureID gesture_id, SDL.RWops dst);

		public static bool save_dollar_template(GestureID gesture_id, string file){
			return save_dollar_template_rw(gesture_id,new SDL.RWops.from_file(file, "wb"));
		}

	}
	
	[CCode (cname="int", cprefix="SDL_", cheader_filename="SDL2/SDL_events.h")]
	public enum EventState {
		QUERY, IGNORE, DISABLE, ENABLE
	}// EventState
	
	[CCode (cname="SDL_eventaction", cprefix="SDL_", cheader_filename="SDL2/SDL_events.h")]
	public enum EventAction {
		ADDEVENT, PEEKEVENT, GETEVENT
	}// EventAction
	
	
	///
	/// Input
	///
	[CCode (cname="int", cprefix="SDL_")]
	public enum ButtonState {
		RELEASED, PRESSED
	}// ButtonState
	
	[CCode (cname="SDL_Keycode", cprefix="SDLK_", cheader_filename="SDL2/SDL_keyboard.h")]
	public enum Keycode {
		UNKNOWN, RETURN, ESCAPE, BACKSPACE, TAB, SPACE, EXCLAIM,
		QUOTEDBL, HASH, PERCENT, DOLLAR, AMPERSAND, QUOTE,
		LEFTPAREN, RIGHTPAREN, ASTERISK, PLUS, COMMA, MINUS,
		PERIOD, SLASH, SDLK_0, SDLK_1, SDLK_2, SDLK_3, SDLK_4,
		SDLK_5, SDLK_6, SDLK_7, SDLK_8, SDLK_9, COLON, SEMICOLON,
		LESS, EQUALS, GREATER, QUESTION, AT, LEFTBRACKET, BACKSLASH,
		RIGHTBRACKET, CARET, UNDERSCORE, BACKQUOTE, a, b, c, d, e, f,
		g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z, CAPSLOCK, F1,
		F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12, PRINTSCREEN,
		SCROLLLOCK, PAUSE, INSERT, HOME, PAGEUP, DELETE, END,
		PAGEDOWN, RIGHT, LEFT, DOWN, UP, NUMLOCKCLEAR, KP_DIVIDE,
		KP_MULTIPLY, KP_MINUS, KP_PLUS, KP_ENTER, KP_1, KP_2, KP_3,
		KP_4, KP_5, KP_6, KP_7, KP_8, KP_9, KP_0, KP_PERIOD, APPLICATION,
		POWER, KP_EQUALS, F13, F14, F15, F16, F17, F18, F19, F20, F21,
		F22, F23, F24, EXECUTE, HELP, MENU, SELECT, STOP, AGAIN, UNDO,
		CUT, COPY, PASTE, FIND, MUTE, VOLUMEUP, VOLUMEDOWN, KP_COMMA,
		KP_EQUALSAS400, ALTERASE, SYSREQ, CANCEL, CLEAR, PRIOR,
		RETURN2, SEPARATOR, OUT, OPER, CLEARAGAIN, CRSEL, EXSEL,
		KP_00, KP_000, THOUSANDSSEPARATOR, DECIMALSEPARATOR,
		CURRENCYUNIT, CURRENCYSUBUNIT, KP_LEFTPAREN, KP_RIGHTPAREN,
		KP_LEFTBRACE, KP_RIGHTBRACE, KP_TAB, KP_BACKSPACE, KP_A, KP_B,
		KP_C, KP_D, KP_E, KP_F, KP_XOR, KP_POWER, KP_PERCENT, KP_LESS,
		KP_GREATER, KP_AMPERSAND, KP_DBLAMPERSAND, KP_VERTICALBAR,
		KP_DBLVERTICALBAR, KP_COLON, KP_HASH, KP_SPACE, KP_AT,
		KP_EXCLAM, KP_MEMSTORE, KP_MEMRECALL, KP_MEMCLEAR, KP_MEMADD,
		KP_MEMSUBTRACT, KP_MEMMULTIPLY, KP_MEMDIVIDE, KP_PLUSMINUS,
		KP_CLEAR, KP_CLEARENTRY, KP_BINARY, KP_OCTAL, KP_DECIMAL,
		KP_HEXADECIMAL, LCTRL, LSHIFT, LALT, LGUI, RCTRL, RSHIFT, RALT,
		RGUI, MODE, AUDIONEXT, AUDIOPREV, AUDIOSTOP, AUDIOPLAY,
		AUDIOMUTE, MEDIASELECT, WWW, MAIL, CALCULATOR, COMPUTER,
		AC_SEARCH, AC_HOME, AC_BACK, AC_FORWARD, AC_STOP, AC_REFRESH,
		AC_BOOKMARKS, BRIGHTNESSDOWN, BRIGHTNESSUP, DISPLAYSWITCH,
		KBDILLUMTOGGLE, KBDILLUMDOWN, KBDILLUMUP, EJECT, SLEEP
	}// Keycode
	
	[CCode (cname="SDL_Keymod", cprefix="KMOD_", cheader_filename="SDL2/SDL_keyboard.h")]
	public enum Keymod {
		NONE, LSHIFT, RSHIFT, LCTRL, RCTRL, LALT, RALT,
		LGUI, RGUI, NUM, CAPS, MODE, RESERVED,
		CTRL, SHIFT, ALT, GUI
	}// Keymod
		
	[CCode (cname="SDL_Scancode", cprefix="SDL_SCANCODE_", cheader_filename="SDL2/SDL_scancode.h")]
	public enum Scancode {
		UNKNOWN, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R,
		S, T, U, V, W, X, Y, Z,
		SDL_SCANCODE_1, SDL_SCANCODE_2,
		SDL_SCANCODE_3, SDL_SCANCODE_4, SDL_SCANCODE_5,
		SDL_SCANCODE_6, SDL_SCANCODE_7, SDL_SCANCODE_8,
		SDL_SCANCODE_9, SDL_SCANCODE_0,
		RETURN, ESCAPE, BACKSPACE, TAB, SPACE, MINUS, EQUALS,
		LEFTBRACKET, RIGHTBRACKET, BACKSLASH, NONUSHASH,
		SEMICOLON, APOSTROPHE, GRAVE, COMMA, PERIOD, SLASH,
		CAPSLOCK, F1, F2, F3, F4, F5, F6, F7, F8, F9, F10, F11, F12,
		PRINTSCREEN, SCROLLLOCK, PAUSE, INSERT, HOME,
		PAGEUP, DELETE, END, PAGEDOWN, RIGHT, LEFT, DOWN, UP,
		NUMLOCKCLEAR, KP_DIVIDE, KP_MULTIPLY, KP_MINUS, KP_PLUS,
		KP_ENTER, KP_1, KP_2, KP_3, KP_4, KP_5, KP_6, KP_7, KP_8,
		KP_9, KP_0, KP_PERIOD, NONUSBACKSLASH, APPLICATION,
		POWER, KP_EQUALS, F13, F14, F15, F16, F17, F18, F19, F20,
		F21, F22, F23, F24, EXECUTE, HELP, MENU, SELECT, STOP,
		AGAIN, UNDO, CUT, COPY, PASTE, FIND, MUTE, VOLUMEUP,
		VOLUMEDOWN, LOCKINGCAPSLOCK, LOCKINGNUMLOCK,
		LOCKINGSCROLLLOCK, KP_COMMA, KP_EQUALSAS400,
		INTERNATIONAL1, INTERNATIONAL2, INTERNATIONAL3,
		INTERNATIONAL4, INTERNATIONAL5, INTERNATIONAL6,
		INTERNATIONAL7, INTERNATIONAL8, INTERNATIONAL9, LANG1,
		LANG2, LANG3, LANG4, LANG5, LANG6, LANG7, LANG8,
		LANG9, ALTERASE, SYSREQ, CANCEL, CLEAR, PRIOR, RETURN2,
		SEPARATOR, OUT, OPER, CLEARAGAIN, CRSEL, EXSEL, KP_00,
		KP_000, THOUSANDSSEPARATOR, DECIMALSEPARATOR,
		CURRENCYUNIT, CURRENCYSUBUNIT, KP_LEFTPAREN,
		KP_RIGHTPAREN, KP_LEFTBRACE, KP_RIGHTBRACE, KP_TAB,
		KP_BACKSPACE, KP_A, KP_B, KP_C, KP_D, KP_E, KP_F, KP_XOR,
		KP_POWER, KP_PERCENT, KP_LESS, KP_GREATER, KP_AMPERSAND,
		KP_DBLAMPERSAND, KP_VERTICALBAR, KP_DBLVERTICALBAR,
		KP_COLON, KP_HASH, KP_SPACE, KP_AT, KP_EXCLAM, KP_MEMSTORE,
		KP_MEMRECALL, KP_MEMCLEAR, KP_MEMADD, KP_MEMSUBTRACT,
		KP_MEMMULTIPLY, KP_MEMDIVIDE, KP_PLUSMINUS, KP_CLEAR,
		KP_CLEARENTRY, KP_BINARY, KP_OCTAL, KP_DECIMAL,
		KP_HEXADECIMAL, LCTRL, LSHIFT, LALT, LGUI, RCTRL, RSHIFT, RALT,
		RGUI, MODE, AUDIONEXT, AUDIOPREV, AUDIOSTOP, AUDIOPLAY,
		AUDIOMUTE, MEDIASELECT, WWW, MAIL, CALCULATOR, COMPUTER,
		AC_SEARCH, AC_HOME, AC_BACK, AC_FORWARD, AC_STOP, AC_REFRESH,
		AC_BOOKMARKS, BRIGHTNESSDOWN, BRIGHTNESSUP, DISPLAYSWITCH,
		KBDILLUMTOGGLE, KBDILLUMDOWN, KBDILLUMUP, EJECT, SLEEP, APP1, APP2
	}// Scancode
	
	[CCode (cname="SDL_Keysym", cheader_filename="SDL2/SDL_keyboard.h")]
	[SimpleType]
	public struct Key {
		SDL.Scancode scancode;
		SDL.Keycode sym;
		uint16 mod;
		uint32 unicode;
	}// Key
	
	[CCode (cheader_filename="SDL2/SDL_keyboard.h")]
	public class Keyboard {
		[CCode (cname="SDL_GetKeyboardFocus")]
		public static SDL.Window get_focus();
		
		[CCode (cname="SDL_GetKeyboardState")]
		public static uint8[] get_state(int[] numkeys);
		
		[CCode (cname="SDL_GetModState")]
		public static SDL.Keymod get_modifierstate();
		
		[CCode (cname="SDL_SetModState")]
		public static void set_modifierstate(SDL.Keymod modstate);
		
		[CCode (cname="SDL_GetKeyFromScancode")]
		public static SDL.Keycode key_fromscancode(SDL.Scancode scancode);
		
		[CCode (cname="SDL_GetScancodeFromName")]
		public static SDL.Scancode scancode_fromkey(SDL.Keycode key);
		
		[CCode (cname="SDL_GetScancodeName")]
		public static unowned string get_scancodename(SDL.Scancode scancode);
		
		[CCode (cname="SDL_GetScancodeFromName")]
		public static SDL.Scancode scancode_fromname(string name);
		
		[CCode (cname="SDL_GetKeyName")]
		public static unowned string get_keyname(SDL.Keycode key);
		
		[CCode (cname="SDL_GetKeyFromName")]
		public static SDL.Keycode keycode_fromname(string name);
	}// Keyboard
	
	[CCode (cheader_filename="SDL2/SDL_keyboard.h")]
	public class TextInput {
		[CCode (cname="SDL_StartTextInput")]
		public static void start();
		
		[CCode (cname="SDL_IsTextInputActive")]
		public static bool is_active();
		
		[CCode (cname="SDL_StopTextInput")]
		public static void stop();
		
		[CCode (cname="SDL_SetTextInputRect")]
		public static void set_rect(SDL.Rect rect);
	}// TextInput
	
	[CCode (cheader_filename="SDL2/SDL_keyboard.h")]
	public class ScreenKeyboard {
		[CCode (cname="SDL_HasScreenKeyboardSupport")]
		public static bool has_support();
		
		[CCode (cname="SDL_IsScreenKeyboardShown")]
		public static bool is_shown(SDL.Window window);
	}
	
	[CCode (cname="SDL_SystemCursor", cprefix="SDL_SYSTEM_CURSOR_", cheader_filename="SDL2/SDL_mouse.h")]
	public enum SystemCursor {
		ARROW, IBEAM, WAIT, CROSSHAIR, WAITARROW, SIZENWSE,
		SIZENESW, SIZEWE, SIZENS, SIZEALL, NO, HAND,
		[CCode(cname="SDL_NUM_SYSTEM_CURSORS")]
		NUM
	}// SystemCursor

	[CCode (cname="Uint8", cprefix="SDL_BUTTON_")]
	public enum MouseButton {
		LEFT, MIDDLE, RIGHT, X1, X2,
		LMASK, MMASK, RMASK, 
		X1MASK,  X2MASK
	}// Buttons
	
	[CCode (type_id="SDL_Cursor", free_function="SDL_FreeCursor", cheader_filename="SDL2/SDL_mouse.h")]
	[Compact]
	public class Cursor {
		[CCode (cname="SDL_GetMouseFocus")]
		public static SDL.Window get_focus();
		
		[CCode (cname="SDL_MouseIsHaptic", cheader_filename="SDL2/SDL_haptic.h")]
		public static int is_haptic();
		
		[CCode (cname="SDL_GetMouseState")]
		public static uint32 get_state(ref int x, ref int y);

		[CCode (cname="SDL_GetGlobalMouseState")]
		public static uint32 get_global_state(ref int? x, ref int? y);


		[CCode (cname="SDL_GetRelativeMouseState")]
		public static uint32 get_relative_state(ref int x, ref int y);
		
		[CCode (cname="SDL_CaptureMouse")]
		public static int toggle_capture (bool active);

		[CCode (cname="SDL_WarpMouse")]
		public static void warp_inwindow(SDL.Window window, int x, int y);

		[CCode (cname="SDL_SetRelativeMouseMode")]
		public static int set_relative_mode(bool enabled);

		[CCode (cname="SDL_GetRelativeMouseMode")]
		public static bool get_relative_mode();

		[CCode (cname="SDL_CreateCursor")]
		public Cursor(uint8* data, uint8* mask, int w, int h, 
			int hot_x, int hot_y);

		[CCode (cname="SDL_CreateColorCursor")]
		public Cursor.from_color(SDL.Surface surface, int hot_x, int hot_y);

		[CCode (cname="SDL_SystemCursor")]
		public Cursor.from_system(SDL.SystemCursor id);

		[CCode (cname="SDL_SetCursor")]
		public void set_active();

		[CCode (cname="SDL_GetCursor")]
		public static SDL.Cursor get_active();
		
		[CCode (cname="SDL_GetDefaultCursor")]
		public static SDL.Cursor get_default();

		[CCode (cname="SDL_ShowCursor")]
		public static int show(int toggle);
	}// Cursor
	
	[CCode (cname="SDL_JoystickGUID", cheader_filename="SDL2/SDL_joystick.h")]
	public struct JoystickGUID{
		uint8 data[16];
	}
	
	[CCode (cname="SDL_JoystickID", cheader_filename="SDL2/SDL_joystick.h")]
	public struct JoystickID : int {}// JoystickID

	
	[CCode (cname="SDL_Joystick", free_function="SDL_JoystickClose", cheader_filename="SDL2/SDL_joystick.h")]
	[Compact]
	public class Joystick {
		[CCode (cname="SDL_NumJoysticks")]
		public static int count();

		[CCode (cname="SDL_JoystickNameForIndex")]
		public static unowned string get_name_for_index(int device_index);

		[CCode (cname="SDL_JoystickOpen")]
		public Joystick(int device_index);

		[CCode (cname="SDL_JoystickName")]
		public unowned string get_name();
		
		[CCode (cname="SDL_JoystickGetDeviceGUID")]
		public static SDL.JoystickGUID get_guid_from_device(int device_index);
		
		[CCode (cname="SDL_JoystickGetGUID")]
		public SDL.JoystickGUID get_guid();
		
		[CCode (cname="SDL_JoystickGetGUIDString")]
		public static void guid_buffer(SDL.JoystickGUID  guid, out uint8[] ps);
		
		//Convenience method, use guid_buffer if the GUID is truncated here
		public static string guid_string(SDL.JoystickGUID guid){
			uint8[16] buf;
			guid_buffer(guid, out buf);
			return (string)buf;
		}
		
		[CCode (cname="SDL_JoystickGetGUIDFromString")]
		public static SDL.JoystickGUID get_guid_from_string(string pch);
		
		[CCode (cname="SDL_JoystickGetAttached")]
		public bool get_attached();
		
		[CCode (cname="SDL_JoystickInstanceID")]
		public SDL.JoystickID get_instance();
		
		[CCode (cname="SDL_JoystickNumAxes")]
		public int num_axes();

		[CCode (cname="SDL_JoystickNumBalls")]
		public int num_balls();

		[CCode (cname="SDL_JoystickNumHats")]
		public int num_hats();

		[CCode (cname="SDL_JoystickNumButtons")]
		public int num_buttons();
		
		[CCode (cname="SDL_JoystickUpdate")]
		public static void update();
		
		[CCode (cname="SDL_JoystickGetAxis")]
		public int16 get_axis(int axis);
		
		[CCode (cname="SDL_JoystickIsHaptic", cheader_filename="SDL2/SDL_haptic.h")]
		public int is_haptic();
		
		[CCode (cname="SDL_JoystickGetHat")]
		public SDL.HatValue get_hat(int hat);

		[CCode (cname="SDL_JoystickGetBall")]
		public SDL.HatValue get_ball(int ball, out int dx, out int dy);

		[CCode (cname="SDL_JoystickGetButton")]
		public SDL.ButtonState get_button(int button);
	}// Joystick
	
	[CCode(cheader_filename="SDL2/SDL_touch.h")]
	namespace Touch{
		[CCode (cname="SDL_TouchID")]
		public struct TouchID : int {}// TouchID
		
		[CCode (cname="SDL_FingerID", cheader_filename="SDL2/SDL_touch.h")]
		public struct FingerID : int {}// FingerID	
		
		[CCode (cname="SDL_TOUCH_MOUSEID")]
		public struct TouchMouseID : uint32 {}
			

		[CCode (cname="SDL_Finger", type_id="SDL_Finger", cheader_filename="SDL2/SDL_touch.h")]
		[Compact]
		public class Finger {
			FingerID id;
			float x;
			float y;
			float pressure;
			
			[CCode (cname="SDL_GetNumTouchDevices")]
			public static int num_devices();
			
			[CCode (cname="SDL_GetTouchDevice")]
			public static TouchID get_touch_device(int index);
			
			[CCode (cname="SDL_GetNumTouchFingers")]
			public static int num_fingers(TouchID touch_id);
			
			[CCode (cname="SDL_GetTouchFinger")]
			public Finger(TouchID touch_id, int index);
		}// Finger
	}
	///
	/// Game Controller
	///
	[CCode (cname="SDL_GameController", free_function="SDL_GameControllerClose", cheader_filename="SDL2/SDL_gamecontroller.h.h")]
	[Compact]
	public class GameController{
		
		[CCode (cname = "SDL_GameControllerOpen")]
		public GameController(int device_index);
		
		
		public string? name{
			[CCode (cname= "SDL_GameControllerName")] get;
		}
		
		[CCode (cname="SDL_GameControllerMapping")]
		public string get_mapping();
		
		[CCode (cname="SDL_GameControllerGetJoystick")]
		public SDL.Joystick to_joystick();
		
		[CCode (cname="SDL_GameControllerGetAttached")]
		public bool is_attached();
		
		[CCode (cname="SDL_GameControllerGetAxis")]
		public int16 get_axis_status (GameController.Axis axis);
		
		[CCode (cname="SDL_GameControllerGetButton")]
		public uint8 get_button_status (GameController.Button button);
		
		[CCode (cname="SDL_GameControllerGetBindForAxis")]
		public SDL.GameController.ButtonBind get_axis_bind(GameController.Axis axis);
		
		[CCode (cname="SDL_GameControllerGetBindForButton")]
		public SDL.GameController.ButtonBind get_button_bind(GameController.Button button);
	
	
		
		[CCode (cname= "SDL_GameControllerEventState")]
		public static void set_event_state(SDL.EventState state);
		
		[CCode (cname= "SDL_IsGameController")]
		public static bool is_game_controller(int device_index);
		
		[CCode (cname="SDL_GameControllerNameForIndex")]
		public static string? name_for_index(int device_index);
		
		[CCode (cname="SDL_GameControllerAddMapping")]
		public static int load_mapping(string mapping);
		
		[CCode (cname="SDL_GameControllerAddMappingsFromFile")]
		public static int load_mapping_file(string path);
		
		[CCode (cname="SDL_GameControllerAddMappingsFromFile")]
		public static int load_mapping_rw(SDL.RWops rw, bool freerw = true);
		
		[CCode (cname="SDL_GameControllerMappingForGUID")]
		public static string mapping_for_guid(SDL.JoystickGUID guid);
		
		public static int count(){
			int controllernum = 0;
			for ( int i = 0; i < SDL.Joystick.count(); i++ ) {
				if ( is_game_controller(i) ){
					controllernum++;
				}
			}
			return controllernum;
		}
		
		[CCode (cname="SDL_GameControllerUpdate")]
		public static void update_controls();
		
		[CCode (cprefix="SDL_CONTROLLER_AXIS_", cheader_filename="SDL2/SDL_gamecontroller.h")]
		public enum Axis{
			INVALID, LEFTX, LEFTY, RIGHTX, RIGHTY, TRIGGERLEFT, TRIGGERRIGHT, MAX;
			[CCode (cname="SDL_GameControllerGetStringForAxis")]
			private string? _to_string();
			
			public string to_string(){
				string? val = _to_string();
				return val ?? "INVALID";
			}
			[CCode(cname="SDL_GameControllerGetAxisFromString")]
			public static GameController.Axis from_string(string axis_string);
		}
	
		[CCode (cprefix="SDL_CONTROLLER_BUTTON_", cheader_filename="SDL2/SDL_gamecontroller.h")]
		public enum Button{
			INVALID, A, B, X, Y, BACK, GUIDE, START, LEFTSTICK, RIGHTSTICK, 
			LEFTSHOULDER, RIGHTSHOULDER, DPAD_UP, DPAD_DOWN, DPAD_LEFT, DPAD_RIGHT, MAX;
			[CCode (cname="SDL_GameControllerGetStringForButton")]
			private string? _to_string();
			
			public string to_string(){
				string? val = _to_string();
				return val ?? "INVALID";
			}
			[CCode (cname="SDL_GameControllerGetButtonFromString")]
			public static GameController.Button from_string(string button_string);
		}
		[CCode (cprefix="SDL_CONTROLLER_BINDTYPE_", cheader_filename="SDL2/SDL_gamecontroller.h")]
		public enum BindType{
			NONE, BUTTON, AXIS, HAT	
		}
		
		[CCode (cname= "SDL_GameControllerButtonBind")]
		public struct ButtonBind{
			[CCode(cname="bindType")]
			BindType bind_type;
			
			[CCode (cname="value.button")]
			int button;
			[CCode (cname="value.axis")]
			int axis;
			[CCode (cname="value.hat.hat")]
			int hat;
			[CCode (cname="value.hat.hat_mask")]
			int hat_mask;
		}
	}
	
	
	
	///
	/// Force Feedback
	///
	[CCode (cname="SDL_Haptic", destroy_function="SDL_HapticClose", cheader_filename="SDL2/SDL_haptic.h")]
	[Compact]
	public class Haptic{
		[CCode (cname="Uint8", cprefix="SDL_HAPTIC_", cheader_filename="SDL2/SDL_haptic.h")]
		public enum DirectionType{
			POLAR, CARTESIAN, SPHERICAL
		}
		[Flags, CCode (cname="Uint16", cprefix="SDL_HAPTIC_", cheader_filename="SDL2/SDL_haptic.h")]
		public enum EffectType{
			SINE, SQUARE, TRIANGLE, SAWTOOTHUP, SAWTOOTHDOWN, CONSTANT, 
			CUSTOM, LEFTRIGHT, SPRING, DAMPER, INERTIA, FRICTION, RAMP
		}
		[CCode (cname="SDL_HapticDirection", cheader_filename="SDL2/SDL_haptic.h")]
		[SimpleType]
		public struct HapticDirection{
			public DirectionType type;
			public int32 dir;
		}
		[CCode (cname="SDL_HapticPeriodic", cheader_filename="SDL2/SDL_haptic.h")]
		public struct HapticPeriodic{
			//Header
			public EffectType type;
			public HapticDirection direction; 
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Periodic
			public uint16 period;
			public int16 magnitude;
			public int16 offset;
			public uint16 phase;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}
		
		[CCode (cname="SDL_HapticConstant", cheader_filename="SDL2/SDL_haptic.h")]
		public struct HapticConstant{
			//Header
			public EffectType type;
			public HapticDirection direction; 
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Constant
			public int16 level;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}
		
		[CCode (cname="SDL_HapticCondition", cheader_filename="SDL2/SDL_haptic.h")]
		public struct HapticCondition{
			//Header
			public EffectType type;
			public HapticDirection direction; 
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Condition
			public uint16 right_sat;
			public uint16 left_sat;
			public int16 right_coeff;
			public int16 left_coeff;
			public uint16 deadband;
			public int16 center;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}
		[CCode (cname="SDL_HapticRamp", cheader_filename="SDL2/SDL_haptic.h")]
		public struct HapticRamp{
			//Header
			public EffectType type;
			public HapticDirection direction; 
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Ramp
			public int16 start;
			public int16 end;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}
		[CCode (cname="SDL_HapticLeftRight", cheader_filename="SDL2/SDL_haptic.h")]
		public struct HapticLeftRight{
			//Header
			public EffectType type;
			//Replay
			public uint32 length;
			//Rumble
			public uint16 large_magnitude;
			public uint16 small_magnitude;
		}
		[CCode (cname="SDL_HapticCustom", cheader_filename="SDL2/SDL_haptic.h")]
		public struct HapticCustom{
			//Header
			public EffectType type;
			public HapticDirection direction; 
			//Replay
			public uint32 length;
			public uint16 delay;
			//Trigger
			public uint16 button;
			public uint16 interval;
			//Custom
			public uint8 channels;
			public uint16 period;
			public uint16 samples;
			public uint16[] data;
			//Envelope
			public uint16 attack_length;
			public uint16 attack_level;
			public uint16 fade_langth;
			public uint16 fade_level;
		}
	
		[CCode (cname= "SDL_HapticEffect", has_type_id=false, has_target=false, destroy_function="", cheader_filename="SDL2/SDL_haptic.h")]
		[SimpleType]
		public struct HapticEffect{
			public EffectType type;
			public HapticConstant constant;
			public HapticPeriodic periodic;
			public HapticCondition condition;
			public HapticRamp ramp;
			public HapticLeftRight leftright;
			public HapticCustom custom;
		}
		
		
		[CCode (cname="SDL_HapticOpen")]
		public Haptic(int device_index);
		[CCode (cname="SDL_HapticOpenfromJoystick")]
		public Haptic.from_joystick(Joystick joystick);
		[CCode (cname="SDL_HapticOpenfromMouse")]
		public Haptic.from_mouse();
		[CCode (cname="SDL_NumHaptics")]
		public static int num_devices();
		[CCode (cname="SDL_HapticName")]
		public static unowned string device_name(int device_index);
		[CCode (cname="SDL_HapticNewEffect")]
		public int upload_effect(HapticEffect effect);
		[CCode (cname="SDL_HapticRunEffect")]
		public int run_effect(int effect_id);
		[CCode (cname="SDl_HapticUpdateEffect")]
		public int update_effect(int effect_id, HapticEffect new_effect);
		[CCode (cname="SDL_HapticDestroyEffect")]
		public int destroy_effect(int effect_id);
		[CCode (cname="SDL_HapticGetEffectStatus")]
		public int get_effect_status(int effect_id);
		//Returns negative on error, that's why it's not a bool
		[CCode (cname="SDL_HapticEffectSupported")]
		public int supports_effect(HapticEffect effect);
		[CCode (cname="SDL_HapticNumEffects")]
		public int effects_capacity();
		[CCode (cname="SDL_HapticNumEffectsPlaying")]
		public int effects_playing();
		[CCode (cname="SDL_HapticNumAxes")]
		public int num_axes();
		[CCode (cname="SDL_HapticIndex")]
		public int get_index();
		[CCode (cname="SDL_HapticSetGain")]
		public int set_gain(int gain);
		[CCode (cname="SDL_HapticsetAutocenter")]
		public int set_autocenter(int percentage);
		[CCode (cname="SDL_HapticRumbleInit")]
		public int rumble_init();
		[CCode (cname="SDL_HapticRumblePlay")]
		public int rumble_play();
		[CCode (cname="SDL_HapticRumbleStop")]
		public int rumble_stop();
		[CCode (cname="SDL_HapticRumbleSupported")]
		public int rumble_supported();
		[CCode (cname="SDL_HapticOpened")]
		public bool is_open();
		[CCode (cname="SDL_HapticQuery")]
		public uint query();
		[CCode (cname="SDL_HapticPause")]
		public int pause();
		[CCode (cname="SDL_HapticUnpause")]
		public int resume();
		[CCode (cname="SDL_HapticStopAll")]
		public int stop();
		[CCode (cname="SDL_HapticStopEffect")]
		public int stop_effect(int effect_id);
	
	}//Force Feedback
	
	
	///
	/// Audio
	///
	
	[CCode (cheader_filename="SDL2/SDL_audio.h")]
	namespace Audio {
		[CCode (cname="Uint16", cprefix="AUDIO_", cheader_filename="SDL2/SDL_audio.h")]
		public enum Format {
		U8, S8, U16LSB, S16LSB, U16MSB, S16MSB, U16, S16,
		S32LSB, S32MSB, S32, F32LSB, F32MSB, F32,
		U16SYS, S16SYS, U32SYS, S32SYS,
		}// AudioFormat

		[CCode (cname="int", cprefix="SDL_AUDIO_")]
		public enum Status {
			STOPPED, PLAYING, PAUSED
		}// AudioStatus
	
			[CCode (cname="int", cprefix="SDL_AUDIO_ALLOW_", cheader_filename="SDL2/SDL_audio.h")]
		public enum AllowFlags {
			FREQUENCY_CHANGE,
			FORMAT_CHANGE,
			CHANNELS_CHANGE,
			ANY_CHANGE
		}// AudioAllowFlags

		[CCode (cname="SDL_AudioCallback", instance_pos = 0.1, has_target = true, delegate_target_pos=0,   cheader_filename="SDL2/SDL_audio.h")]
		public delegate void Callback(uint8[] stream, int len);

		[CCode (cname="SDL_AudioSpec", cheader_filename="SDL2/SDL_audio.h")]
		public struct Spec {
			public int freq;
			public SDL.Audio.Format format;
			public uint8 channels;
			public uint8 silence;
			public uint16 samples;
			public uint16 padding;
			public uint32 size;
			[CCode (delegate_target_cname = "userdata")]
			public unowned SDL.Audio.Callback callback;
		}// AudioSpec
		
		[CCode (cname="SDL_AudioFilter", instance_pos = 0.1, cheader_filename="SDL2/SDL_audio.h")]
		public delegate void Filter(Audio.Converter cvt, Audio.Format format);

		[CCode (cname="SDL_AudioCVT", cheader_filename="SDL2/SDL_audio.h")]
		public struct Converter {
			public int needed;
			public SDL.Audio.Format src_format;
			public SDL.Audio.Format dst_format;
			public double rate_incr;
			public uint8* buf;
			public int len;
			public int len_cvt;
			public int len_mult;
			public double len_ratio;
			public Audio.Filter filters[10];
			public int filter_index;

			[CCode (cname="SDL_BuildAudioCVT")]
			public static int build(Audio.Converter cvt, Audio.Format src_format, 
			uchar src_channels, int src_rate, Audio.Format dst_format, 
			uchar dst_channels, int dst_rate);

			[CCode (cname="SDL_ConvertAudio")]
			public int convert();
		}// AudioConverter
	
		[CCode (cname="SDL_AudioDeviceID", has_type_id = false, cheader_filename="SDL2/SDL_audio.h")]
		[SimpleType]
		[IntegerType (rank = 7)]
		public struct Device : uint32 {
			[CCode (cname="SDL_OpenAudioDevice")]
			public Device(string device_name, bool is_capture, 
								Audio.Spec desired, Audio.Spec obtained,
				int allowed_changes);
			
			[CCode (cname="SDL_PauseAudioDevice")]
			public void pause(int pause_on);
			
			[CCode (cname="SDL_GetAudioDeviceStatus")]
			public Audio.Status get_status();
						
			[CCode (cname="SDL_LockAudioDevice")]
			public void do_lock();

			[CCode (cname="SDL_LockAudioDevice")]
			public void unlock();

		
		}// AudioDeviceID

	
		[CCode (cname="SDL_GetNumAudioDrivers")]
		public static int num_drivers();
		
		[CCode (cname="SDL_GetAudioDriver")]
		public static unowned string get_driver(int index);
		
		[CCode (cname="SDL_AudioInit")]
		public static int init(string driver);
		
		[CCode (cname="SDL_AudioQuit")]
		public static void quit();
		
		[CCode (cname="SDL_GetCurrentAudioDriver")]
		public static unowned string get_current_driver();
		
		[CCode (cname="SDL_OpenAudio")]
		public static int open(Audio.Spec desired, out Audio.Spec obtained);
		
		[CCode (cname="SDL_GetNumAudioDevices")]
		public static int num_devices();
		
		[CCode (cname="SDL_GetAudioDeviceName")]
		public static unowned string get_device_name(int index);
		
		[CCode (cname="SDL_GetAudioStatus")]
		public static Audio.Status status();
		
		[CCode (cname="SDL_PauseAudio")]
		public static void pause(int pause_on);
		
		[CCode (cname="SDL_LoadWAV_RW")]
		public static unowned Audio.Spec? load_rw(RWops src, int freesrc, ref Audio.Spec spec, out uint8[] audio_buf, out uint32 audio_len);

		public static unowned Audio.Spec? load(string file, ref Audio.Spec spec, out uint8[] audio_buf, out uint32 audio_len){
			return load_rw(new SDL.RWops.from_file(file, "rb"), 1,
			ref spec, out audio_buf, out audio_len);
		}
		
		[CCode (cname="SDL_FreeWAV")]
		public static void free(ref uint8 audio_buf);
		
		[CCode (cname="SDL_MixAudio")]
		public static void mix(out uint8[] dst, uint8[] src, uint32 len, int volume);
		
		[CCode (cname="SDL_MixAudioFormat")]
		public static void mix_device(out uint8[] dst, uint8[] src, SDL.Audio.Format format, uint32 len, int volume);

		[CCode (cname="SDL_LockAudio")]
		public static void do_lock();

		[CCode (cname="SDL_UnlockAudio")]
		public static void unlock();

		[CCode (cname="SDL_CloseAudio")]
		public static void close();

		[CCode (cname="SDL_CloseAudioDevice")]
		public static void close_device(SDL.Audio.Device dev);

		[CCode (cname="SDL_AudioDeviceConnected")]
		public static int is_device_connected(SDL.Audio.Device dev);
	}// Audio
	
	
	///
	/// Timers
	///
	[CCode (cname="SDL_TimerCallback", cheader_filename="SDL2/SDL_timer.h", has_target = true,  delegate_target_pos = 0.1)]
	public delegate uint32 TimerCallback(uint32 interval);

	[CCode (cname="SDL_TimerID", ref_function="", unref_function="", cheader_filename="SDL2/SDL_timer.h")]
	[Compact]
	public class Timer {
		[CCode (cname="SDL_GetTicks")]
		public static uint32 get_ticks();

		[CCode (cname="SDL_GetPerformanceCounter")]
		public static uint64 get_performance_counter();

		[CCode (cname="SDL_GetPerformanceFrequency")]
		public static uint64 get_performance_frequency();

		[CCode (cname="SDL_Delay")]
		public static void delay(uint32 ms);

		[CCode (cname="SDL_AddTimer", delegate_target_pos= 1.1)]
		public Timer (uint32 interval, SDL.TimerCallback callback);
		
		[CCode (cname="SDL_RemoveTimer")]
		[DestroysInstance]
		public bool remove ();
	}// Timer
	
	
	///
	/// Render
	///
	[CCode (cname="SDL_RendererFlags", cprefix="SDL_RENDERER_", cheader_filename="SDL2/SDL_render.h")]
	public enum RendererFlags {
		SOFTWARE, ACCELERATED,
		PRESENTVSYNC, TARGETTEXTURE
	}// RendererFlags
	
	[CCode (cprefix="SDL_", cname = "SDL_RendererInfo", cheader_filename="SDL2/SDL_render.h")]
	[Compact]
	public class RendererInfo {

		public const string name;
		
		public uint32 flags;
		
		[CCode (cname="num_texture_formats")]
		public uint32 num_texture_formats;
		
		[CCode (cname="texture_formats")]
		public SDL.PixelFormat texture_formats[16];
		
		[CCode (cname="max_texture_width")]
		public int max_texture_width;
		
		[CCode (cname="texture_formats")]
		public int max_texture_height;
	}// RendererInfo

	[Flags, CCode (cname="SDL_TextureAccess", cprefix="SDL_TEXTUREACCESS_", cheader_filename="SDL2/SDL_render.h")]
	public enum TextureAccess {
		STATIC, STREAMING, TARGET
	}// TextureAccess

	[Flags, CCode (cname="SDL_TextureModulate", cprefix="SDL_TEXTUREMODULATE_", cheader_filename="SDL2/SDL_render.h")]
	public enum TextureModulate {
		NONE, COLOR, ALPHA
	}// TextureModulate

	[Flags, CCode (cname="SDL_RendererFlip", cprefix="SDL_FLIP_", cheader_filename="SDL2/SDL_render.h")]
	public enum RendererFlip {
		NONE, HORIZONTAL, VERTICAL
	}// RendererFlip
	
	[CCode (cprefix="SDL_", cname = "SDL_Renderer", destroy_function = "SDL_DestroyTexture", cheader_filename="SDL2/SDL_render.h")]
	[Compact]
	public class Renderer {
		[CCode (cname="SDL_GetNumRenderDrivers")]
		public static int num_drivers();
		
		[CCode (cname="SDL_GetRenderDriverInfo")]
		public static int get_driver_info(int index, SDL.RendererInfo info);
		
		[CCode (cname="SDL_CreateWindowAndRenderer")]
		public static int create_with_window(int width, int height, SDL.WindowFlags window_flags, out SDL.Window window, out SDL.Renderer renderer);
		
		[CCode (cname="SDL_CreateRenderer")]
		public static Renderer? create(SDL.Window window, int index, uint32 flags);
		
		[CCode (cname="SDL_CreateSoftwareRenderer")]
		public static Renderer? create_from_surface(SDL.Surface surface);
		
		[CCode (cname="SDL_GetRendererInfo")]
		public int get_info(out SDL.RendererInfo info);
		
		[CCode (cname="SDL_RenderTargetSupported")]
		public bool is_supported();
	
		[CCode (cname="SDL_SetRenderTarget")]
		public int set_render_target(SDL.Texture texture);
	
		[CCode (cname="SDL_GetRenderTarget")]
		public SDL.Texture get_render_target(out SDL.Texture? texture);
	
		[CCode (cname="SDL_RenderSetLogicalSize")]
		public int set_logical_size(int w, int h);
	
		[CCode (cname="SDL_RenderGetLogicalSize")]
		public void get_logical_size(out int w, out int h);
	
		[CCode (cname="SDL_RenderSetViewport")]
		public int set_viewport(SDL.Rect rect);
	
		[CCode (cname="SDL_RenderGetViewport")]
		public void get_viewport(out SDL.Rect rect);
	
		[CCode (cname="SDL_RenderSetScale")]
		public int set_scale(float scale_x, float scale_y);
	
		[CCode (cname="SDL_RenderGetScale")]
		public void get_scale(out float scale_x, out float scale_y);
		
		[CCode (cname="SDL_SetRenderDrawColor")]
		public int set_draw_color(uint8 r, uint8 g, uint8 b, uint8 a);
		
		[CCode (cname="SDL_GetRenderDrawColor")]
		public int get_draw_color(out uint8 r, out uint8 g, out uint8 b, out uint8 a);
		
		[CCode (cname="SDL_SetRenderDrawBlendMode")]
		public int set_draw_blend_mod(SDL.BlendMode blend_mode);
		
		[CCode (cname="SDL_GetRenderDrawBlendMode")]
		public int get_draw_blend_mod(out SDL.BlendMode blend_mode);
		
		[CCode (cname="SDL_RenderClear")]
		public int clear();
		
		[CCode (cname="SDL_RenderDrawPoint")]
		public int draw_point(int x, int y);
		
		[CCode (cname="SDL_RenderDrawPoints")]
		public int draw_points(SDL.Point[] points);
		
		[CCode (cname="SDL_RenderDrawLine")]
		public int draw_line(int x1, int y1, int x2, int y2);
		
		[CCode (cname="SDL_RenderDrawLines")]
		public int draw_lines(SDL.Point[] points);
		
		[CCode (cname="SDL_RenderDrawRect")]
		public int draw_rect(SDL.Rect? rect);
		
		[CCode (cname="SDL_RenderDrawLines")]
		public int draw_rects(SDL.Rect[] points, int count);
		
		[CCode (cname="SDL_RenderFillRect")]
		public int fill_rect(SDL.Rect? rect);
		
		[CCode (cname="SDL_RenderFillRects")]
		public int fill_rects(SDL.Rect[] points, int count);
		
		[CCode (cname="SDL_RenderCopy")]
		public int copy(SDL.Texture texture, SDL.Rect? srcrect, SDL.Rect? dstrect);
		
		[CCode (cname="SDL_RenderCopyEx")]
		public int copyex(SDL.Texture texture, SDL.Rect? srcrect, SDL.Rect? dstrect, double angle, SDL.Point? center, SDL.RendererFlip flip);
		
		[CCode (cname="SDL_RenderReadPixels")]
		public int read_pixels(SDL.Rect? rect, SDL.PixelRAWFormat format, out void* pixels, int pitch);
		
		[CCode (cname="SDL_RenderPresent")]
		public void present();
	}// Renderer
	
	[CCode (cprefix="SDL_", cname = "SDL_Texture", destroy_function = "SDL_DestroyTexture", free_function="SDL_DestroyTexture", cheader_filename="SDL2/SDL_render.h")]
	[Compact]
	public class Texture {
		[CCode (cname="SDL_CreateTexture")]
		public static Texture? create(SDL.Renderer renderer, SDL.PixelRAWFormat format, int access, int w, int h);
		
		[CCode (cname="SDL_CreateTextureFromSurface")]
		public static Texture? create_from_surface(SDL.Renderer renderer, SDL.Surface surface);
		
		[CCode (cname="SDL_QueryTexture")]
		public int query(out SDL.PixelRAWFormat format, out int access, out int w, out int h); 
		
		[CCode (cname="SDL_SetTextureColorMod")]
		public int set_color_mod(uint8 r, uint8 g, uint8 b);
		
		[CCode (cname="SDL_GetTextureColorMod")]
		public int get_color_mod(out uint8 r, out uint8 g, out uint8 b);
		
		[CCode (cname="SDL_SetTextureAlphaMod")]
		public int set_alpha_mod(uint8 alpha);
		
		[CCode (cname="SDL_GetTextureColorMod")]
		public int get_alpha_mod(out uint8 alpha);
		
		[CCode (cname="SDL_SetTextureBlendMode")]
		public int set_blend_mod(SDL.BlendMode blend_mode);
		
		[CCode (cname="SDL_GetTextureBlendMode")]
		public int get_blend_mod(out SDL.BlendMode blend_mode);
		
		[CCode (cname="SDL_UpdateTexture")]
		public int update(SDL.Rect? rect, void* pixels, int pitch);
		
		[CCode (cname="SDL_LockTexture")]
		public int do_lock(SDL.Rect? rect, void* pixels, int pitch);
		
		[CCode (cname="SDL_UnlockTexture")]
		public void unlock();
		
		[CCode (cname="SDL_GL_BindTexture")]
		public void gl_bind(ref float texw, ref float texh);
		
		[CCode (cname="SDL_GL_UnbindTexture")]
		public int gl_unbind();
	}// Texture
	
	
	///
	/// Threading
	///
	[CCode (has_target = true)]
	public delegate int ThreadFunc();
 
 	
	[CCode (cname="SDL_ThreadPriority", cprefix="SDL_THREAD_PRIORITY_", cheader_filename="SDL2/SDL_thread.h")]
	public enum ThreadPriority{
		LOW, NORMAL, HIGH
	}
 
	[CCode (cname="SDL_Thread", free_function="SDL_WaitThread", cheader_filename="SDL2/SDL_thread.h")]
	[Compact]
	public class Thread {
		[CCode (cname="SDL_CreateThread", delegate_target_pos= 1.1)]
		public Thread(ThreadFunc f, string name);

		[CCode (cname="SDL_ThreadID")]
		public static uint32 id();

		[CCode (cname="SDL_GetThreadID")]
		public uint32 get_id();

		[CCode (cname="SDL_GetThreadName")]
		public string get_name();

		[CCode (cname="SDL_SetThreadPriority")]
		public static int set_priotity(ThreadPriority priority);
 
 		[CCode (cname="SDL_DetachThread")]
		public void detach(); 
	}// Thread
 
	[CCode (cname="SDL_Mutex", free_function="SDL_DestroyMutex")]
	[Compact]
	public class Mutex {
		[CCode (cname="SDL_CreateMutex")]
		public Mutex();
	
		[CCode (cname="SDL_TryLockMutex")]
 		public int try_lock();
 		
		[CCode (cname="SDL_LockMutex")]
		public int do_lock();
 
		[CCode (cname="SDL_UnlockMutex")]
		public int unlock();
	}// Mutex
 
	[CCode (cname="SDL_sem", free_function="SDL_DestroySemaphore")]
	[Compact]
	public class Semaphore {
		[CCode (cname="SDL_CreateSemaphore")]
		public Semaphore(uint32 initial_value);
		 
		[CCode (cname="SDL_SemWait")]
		public int wait();
		 
		[CCode (cname="SDL_SemTryWait")]
		public int try_wait();
		 
		[CCode (cname="SDL_SemWaitTimeout")]
		public int wait_timeout(uint32 ms);
		 
		[CCode (cname="SDL_SemPost")]
		public int post();
		 
		[CCode (cname="SDL_SemValue")]
		public uint32 get_value();
	}// Semaphore
 
	[CCode (cname="SDL_cond", free_function="SDL_DestroyCond")]
	[Compact]
	public class Condition {
		[CCode (cname="SDL_CreateCond")]
		public Condition();
		 
		[CCode (cname="SDL_CondSignal")]
		public int signalize();
		 
		[CCode (cname="SDL_CondBroadcast")]
		public int broadcast();
		 
		[CCode (cname="SDL_CondWait")]
		public int wait(SDL.Mutex mut);
		 
		[CCode (cname="SDL_CondWaitTimeout")]
		public int wait_timeout(SDL.Mutex mut, uint32 ms);
	}// Condition
	 
}// SDL
