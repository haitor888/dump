package com.larrio.dump.tags
{
	import com.larrio.dump.codec.FileDecoder;
	import com.larrio.dump.codec.FileEncoder;
	import com.larrio.dump.model.ClipActions;
	import com.larrio.dump.model.ColorTransformRecord;
	import com.larrio.dump.model.MatrixRecord;
	
	/**
	 * 
	 * @author larryhou
	 * @createTime Dec 26, 2012 9:50:56 AM
	 */
	public class PlaceObject2 extends PlaceObject
	{
		public static const TYPE:uint = TagType.PLACE_OBJECT2;
		
		private var _hasClipActions:uint;
		private var _hasClipDepth:uint;
		
		private var _hasName:uint;
		private var _hasRatio:uint;
		private var _hasColorTransform:uint;
		private var _hasMatrix:uint;
		private var _hasCharacter:uint;
		private var _move:uint;
		
		private var _ratio:uint;
		private var _name:String;
		private var _clipDepth:uint;
		
		private var _clipActions:ClipActions;
		
		
		/**
		 * 构造函数
		 * create a [PlaceObject2] object
		 */
		public function PlaceObject2()
		{
			
		}
		
		/**
		 * 对TAG二进制内容进行解码 
		 * @param decoder	解码器
		 */		
		override protected function decodeTag(decoder:FileDecoder):void
		{
			_hasClipActions = decoder.readUB(1);
			_hasClipDepth = decoder.readUB(1);
			_hasName = decoder.readUB(1);
			_hasRatio = decoder.readUB(1);
			_hasColorTransform = decoder.readUB(1);
			_hasMatrix = decoder.readUB(1);
			_hasCharacter = decoder.readUB(1);
			
			_move = decoder.readUB(1);
			
			_depth = decoder.readUI16();
			if (_hasCharacter)
			{
				_character = decoder.readUI16();
			}
			
			if (_hasMatrix)
			{
				_matrix = new MatrixRecord();
				_matrix.decode(decoder);
			}
			
			if (_hasColorTransform)
			{
				_colorTransform = new ColorTransformRecord(true);
				_colorTransform.decode(decoder);
			}
			
			if (_hasRatio)
			{
				_ratio = decoder.readUI16();
			}
			
			if (_hasName)
			{
				_name = decoder.readSTR();
			}
			
			if (_hasClipDepth)
			{
				_clipDepth = decoder.readUI16();
			}
			
			if (_hasClipActions)
			{
				_clipActions = new ClipActions();
				_clipActions.decode(decoder);
			}
		}
		
		/**
		 * 对TAG内容进行二进制编码 
		 * @param encoder	编码器
		 */		
		override protected function encodeTag(encoder:FileEncoder):void
		{
			encoder.writeUB(_hasClipActions, 1);
			encoder.writeUB(_hasClipDepth, 1);
			encoder.writeUB(_hasName, 1);
			encoder.writeUB(_hasRatio, 1);
			encoder.writeUB(_hasColorTransform, 1);
			encoder.writeUB(_hasMatrix, 1);
			encoder.writeUB(_hasCharacter, 1);
			encoder.writeUB(_move, 1);
			encoder.flush();
			
			encoder.writeUI16(_depth);
			
			if (_hasCharacter)
			{
				encoder.writeUI16(_character);
			}
			
			if (_hasMatrix)
			{
				_matrix.encode(encoder);
			}
			
			if (_hasColorTransform)
			{
				_colorTransform.encode(encoder);
			}
			
			if (_hasRatio)
			{
				encoder.writeUI16(_ratio);
			}
			
			if (_hasName)
			{
				encoder.writeSTR(_name);
			}
			
			if (_hasClipDepth)
			{
				encoder.writeUI16(_clipDepth);
			}
			
			if (_hasClipActions)
			{
				_clipActions.encode(encoder);
			}
		}
		
		/**
		 * 字符串输出
		 */		
		override public function toString():String
		{
			return "";	
		}
		
		/**
		 * Defines a character to be moved
		 */		
		public function get move():uint { return _move; }

		/**
		 * retaio
		 */		
		public function get ratio():uint { return _ratio; }

		/**
		 * Name of character
		 */		
		public function get name():String { return _name; }

		/**
		 * Clip depth
		 */		
		public function get clipDepth():uint { return _clipDepth; }

		/**
		 * Clip Actions Data
		 */		
		public function get clipActions():ClipActions { return _clipActions; }

	}
}