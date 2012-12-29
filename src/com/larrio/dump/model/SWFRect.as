package com.larrio.dump.model
{
	import com.larrio.dump.codec.FileDecoder;
	import com.larrio.dump.codec.FileEncoder;
	import com.larrio.dump.interfaces.ICodec;
	
	/**
	 * SWF矩形
	 * @author larryhou
	 * @createTime Dec 16, 2012 10:17:33 AM
	 */
	public class SWFRect implements ICodec
	{
		private var _minX:int;
		private var _maxX:int;
		
		private var _minY:int;
		private var _maxY:int;
		
		// 数据占用比特位数量
		private var _nbits:uint;
		
		private var _width:int;
		private var _height:int;
				
		/**
		 * 构造函数
		 * create a [SWFRect] object
		 */
		public function SWFRect()
		{
			
		}
		
		/**
		 * 二进制编码 
		 * @param encoder	编码器
		 */		
		public function encode(encoder:FileEncoder):void
		{
			encoder.flush();
			encoder.writeUB(_nbits, 5);
			encoder.writeSB(_minX, _nbits);
			encoder.writeSB(_maxX, _nbits);
			encoder.writeSB(_minY, _nbits);
			encoder.writeSB(_maxY, _nbits);
		}
		
		/**
		 * 二进制解码 
		 * @param decoder	解码器
		 */		
		public function decode(decoder:FileDecoder):void
		{
			decoder.byteAlign();
			_nbits = decoder.readUB(5);
			
			_minX = decoder.readSB(_nbits);
			_maxX = decoder.readSB(_nbits);
			
			_minY = decoder.readSB(_nbits);
			_maxY = decoder.readSB(_nbits);
			
			_width = (_maxX - _minX) / 20;
			_height = (_maxY - _minY) / 20;
		}
		
		/**
		 * 字符串输出
		 */		
		public function toString():String
		{
			var result:XML = new XML("<Rect/>");
			result.@minX = _minX;
			result.@minY = _minY;
			result.@maxX = _maxX;
			result.@maxY = _maxY;
			return result.toXMLString();
		}

		/**
		 * SWF左边界：twips 
		 */		
		public function get minX():int { return _minX; }

		/**
		 * SWF右边界：twips 
		 */		
		public function get maxX():int { return _maxX; }

		/**
		 * SWF上边界：twips 
		 */		
		public function get minY():int { return _minY; }

		/**
		 * SWF下边界：twips 
		 */		
		public function get maxY():int { return _maxY; }

		/**
		 * SWF宽度：像素 
		 */		
		public function get width():int { return _width; }

		/**
		 * SWF高度：像素
		 */		
		public function get height():int { return _height; }

	}
}