/*****************************************************
*  
*  Copyright 2009 Adobe Systems Incorporated.  All Rights Reserved.
*  
*****************************************************
*  The contents of this file are subject to the Mozilla Public License
*  Version 1.1 (the "License"); you may not use this file except in
*  compliance with the License. You may obtain a copy of the License at
*  http://www.mozilla.org/MPL/
*   
*  Software distributed under the License is distributed on an "AS IS"
*  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
*  License for the specific language governing rights and limitations
*  under the License.
*   
*  
*  The Initial Developer of the Original Code is Adobe Systems Incorporated.
*  Portions created by Adobe Systems Incorporated are Copyright (C) 2009 Adobe Systems 
*  Incorporated. All Rights Reserved. 
*  
*****************************************************/
package com.realeyes.osmf.media
{
	import org.osmf.elements.AudioElement;
	import org.osmf.elements.F4MElement;
	import org.osmf.elements.F4MLoader;
	import org.osmf.elements.ImageElement;
	import org.osmf.elements.ImageLoader;
	import org.osmf.elements.SWFElement;
	import org.osmf.elements.SWFLoader;
	import org.osmf.elements.SoundLoader;
	import org.osmf.media.MediaElement;
	import org.osmf.media.MediaFactory;
	import org.osmf.media.MediaFactoryItem;
	import org.osmf.net.NetLoader;
	import org.osmf.net.dvr.DVRCastNetLoader;
	import org.osmf.net.rtmpstreaming.RTMPDynamicStreamingNetLoader;
	
/*	CONFIG::ENABLE_HTTP_AND_DRM
	{
	import org.osmf.net.httpstreaming.HTTPStreamingNetLoader;
	}*/

	
	/**
	 * DefaultMediaFactory is the default implementation of MediaFactory.
	 * 
	 * <p>
     * The default media factory can construct media elements of
	 * the following types:
	 * 
	 * <ul>
	 * <li>
	 * VideoElement, using either:
	 * <ul>
	 * <li>
	 *   NetLoader (streaming or progressive)
	 * </li>
	 * <li>
	 * 	 RTMPDynamicStreamingNetLoader (MBR streaming)
	 * </li>
	 * <li>
	 * 	 HTTPStreamingNetLoader (HTTP streaming), if the CONFIG::FLASH_10_1 compiler flag is set to true
	 * </li>
	 * <li>
	 * 	 F4MLoader (Flash Media Manifest files)
	 * </li>
	 * <li>
	 *   DVRCastNetLoader (DVRCast)
	 * </li>
	 * </ul>
	 * </li>
	 * <li>
	 * SoundElement, using either:
	 * <ul>
	 * <li>
	 * 	 SoundLoader (progressive)
	 * </li>
	 * <li>
	 * 	 NetLoader (streaming)
	 * </li>
	 * </ul>
	 * </li>
	 * <li>
	 *  ImageElement
	 * </li>
	 * <li>
	 *  SWFElement
	 * </li>
	 * </ul>
	 * </p>
	 *   
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10
	 *  @playerversion AIR 1.5
	 *  @productversion OSMF 1.0
	 * 
	 *  @includeExample DefaultMediaFactoryExample.as -noswf
	 */	
	public class MobileMediaFactory extends MediaFactory
	{
		/**
		 * Constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion OSMF 1.0
		 */		
		public function MobileMediaFactory()
		{
			super();
			
			init();
		}
		
		// Internals
		//
		
		/**
		 * 
		 * This method is called by the constructor. It is responsible
		 * for initializing the f4mLoader and adding all media factory items.
		 * 
		 */
		private function init():void
		{
			f4mLoader = new LightF4MLoader(this);
			addItem 
				( new MediaFactoryItem
					( "org.osmf.elements.f4m"
					, f4mLoader.canHandleResource
					, function():MediaElement
						{
							return new LightF4MElement(null, f4mLoader);
						}
					)
				);
			
			/*dvrCastLoader = new DVRCastNetLoader();
			addItem
				( new MediaFactoryItem
					( "org.osmf.elements.video.dvr.dvrcast"
					, dvrCastLoader.canHandleResource
					, function():MediaElement
						{
							return new LightVideoElement(null, dvrCastLoader);
						}
					)
				);*/
			
/*			CONFIG::ENABLE_HTTP_AND_DRM
			{
			httpStreamingNetLoader = new HTTPStreamingNetLoader();
			addItem
				( new MediaFactoryItem
					( "org.osmf.elements.video.httpstreaming"
					, httpStreamingNetLoader.canHandleResource
					, function():MediaElement
						{
							return new LightVideoElement(null, httpStreamingNetLoader);
						}
					)
				);
			}*/
			
			rtmpStreamingNetLoader = new MobileRTMPDynamicStreamingNetLoader();
			addItem
				( new MediaFactoryItem
					( "org.osmf.elements.video.rtmpdynamicStreaming"
					, rtmpStreamingNetLoader.canHandleResource
					, function():MediaElement
						{
							return new LightVideoElement(null, rtmpStreamingNetLoader);
						}
					)
				);
			
			netLoader = new NetLoader();
			addItem
				( new MediaFactoryItem
					( "org.osmf.elements.video"
					, netLoader.canHandleResource
					, function():MediaElement
						{
							return new LightVideoElement(null, netLoader);
						}
					)
				);		
			
			soundLoader = new SoundLoader();
			addItem
				( new MediaFactoryItem
					( "org.osmf.elements.audio"
					, soundLoader.canHandleResource
					, function():MediaElement
						{
							return new AudioElement(null, soundLoader);
						}
					)
				);
			
			addItem
				( new MediaFactoryItem
					( "org.osmf.elements.audio.streaming"
					, netLoader.canHandleResource
					, function():MediaElement
						{
							return new AudioElement(null, netLoader);
						}
					)
				);
			
			/*imageLoader = new ImageLoader();
			addItem
				( new MediaFactoryItem
					( "org.osmf.elements.image"
					, imageLoader.canHandleResource
					, function():MediaElement
						{
							return new ImageElement(null, imageLoader);
						}
					)
				);
			
			swfLoader = new SWFLoader();
			addItem
				( new MediaFactoryItem
					( "org.osmf.elements.swf"
					, swfLoader.canHandleResource
					, function():MediaElement
						{
							return new SWFElement(null, swfLoader);
						}
					)
				);*/
		}
		
		private var rtmpStreamingNetLoader:MobileRTMPDynamicStreamingNetLoader;
		private var f4mLoader:LightF4MLoader;
		//private var dvrCastLoader:DVRCastNetLoader;
		private var netLoader:NetLoader;
		//private var imageLoader:ImageLoader;
		//private var swfLoader:SWFLoader;
		private var soundLoader:SoundLoader;
		
/*		CONFIG::ENABLE_HTTP_AND_DRM
		private var httpStreamingNetLoader:HTTPStreamingNetLoader;*/
	}
}