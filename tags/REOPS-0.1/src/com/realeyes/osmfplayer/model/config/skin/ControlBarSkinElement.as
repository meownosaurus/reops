/*****************************************************
 *  Copyright 2010 Realeyes Media, LLC.  All Rights Reserved.
 *  
 *  The contents of this file are subject to the Mozilla Public License
 *  Version 1.1 (the "License"); you may not use this file except in
 *  compliance with the License. You may obtain a copy of the License at
 *  http://www.mozilla.org/MPL/
 *   
 *  Software distributed under the License is distributed on an "AS IS" basis, 
 *  WITHOUT WARRANTY OF ANY KIND, either express or implied. 
 *  See the License for the specific language governing 
 *  rights and limitations under the License.
 *  
 *  The Initial Developer of the Original Code is Realeyes Media, LLC..
 *  Portions created by Realeyes Media, LLC. are Copyright (C) 2010 Realeyes Media 
 *  All Rights Reserved. 
 *****************************************************/
package com.realeyes.osmfplayer.model.config.skin
{
	/**
	 * Class representing a skin element for the control bar
	 * 
	 * @author	RealEyes Media
	 * @version	1.0
	 */
	public class ControlBarSkinElement extends SkinElement
	{
		/**
		 * How the component should scale(FIT, SELECT, or NONE)	(String)
		 */
		public var scaleMode:String;
		
		/**
		 * Can the the control bar be dragged?	(Boolean)
		 */
		public var draggable:Boolean;
		
		/**
		 * Should the control bar hide when the user is not interacting?	(Boolean)
		 */
		public var autoHide:Boolean;
		
		public function ControlBarSkinElement()
		{
			super();
		}
		
	}
}