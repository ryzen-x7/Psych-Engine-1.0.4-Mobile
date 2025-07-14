package mobile;

#if sys
import sys.FileSystem;
import sys.io.File;
#end
import openfl.text.Font;
import openfl.media.Sound;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import openfl.utils.ByteArray;
import openfl.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import haxe.crypto.Md5;
import lime.system.System;
import haxe.io.Path;

import sys.FileSystem;

/*
 * A file for internal founder and multiples folders list
 * author: @GXDLOLOLOLOLOLXD2, azeitona-x7 and Idklool for the extra utils... XD
 * 
*/
class Utils
{
    public static function createWatermarkRight(text:String, fontSize:Int = 25, offsetX:Float = 995, offsetY:Float = 50):FlxText
    {
        var xPos:Float = FlxG.width * (offsetX / 1280);
        var yPos:Float = FlxG.height * (offsetY / 720);
        var watermark:FlxText = new FlxText(xPos, yPos, 0, text, fontSize);
        watermark.scrollFactor.set();
        watermark.setFormat(Paths.font("vcr.ttf"), fontSize, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        // watermark.setFormat(null, fontSize, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        return watermark;
    }
    
    public static function createWatermarkLeft(text:String, fontSize:Int = 25, offsetX:Float =664, offsetY:Float = 12):FlxText
    {
        var xPos:Float = FlxG.width * (offsetX / 1280);
        var yPos:Float = FlxG.height * (offsetY / 720);
        var watermark:FlxText = new FlxText(xPos, yPos, 0, text, fontSize);
        watermark.scrollFactor.set();
        watermark.setFormat(Paths.font("vcr.ttf"), fontSize, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        // watermark.setFormat(null, fontSize, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        return watermark;
    }

    public static function exists(id:String, ?type:AssetType):Bool // old assetExists
    {
        //NativeAPI.showMessageBox("Asset Exists", "Checking if asset '${id}' exists: ${Assets.exists(id, type)}");
        return openfl.utils.Assets.exists(id, type);
    }

    public static function getBitmap(id:String):BitmapData
    {
        try {
            return openfl.utils.Assets.getBitmapData(id);
        } catch (e:Dynamic) {
            trace('Error in load image "${id}": ${e}');
            return null; // if gets error, return in null
        }
    }

    public static function getSound(id:String):Sound
    {
        try {
            return openfl.utils.Assets.getSound(id);
        } catch (e:Dynamic) {
            trace('Error in load sound "${id}": ${e}');
            return null; // if gets error, return in null
        }
    }

    public static function getFont(id:String):Font
    {
        try {
            return openfl.utils.Assets.getFont(id);
        } catch (e:Dynamic) {
            trace('Error in load font "${id}": ${e}');
            return null; // if gets error, return in null
        }
    }

    public static function getText(id:String):String
    {
        try {
            return openfl.utils.Assets.getText(id);
        } catch (e:Dynamic) {
            trace('Error in load text "${id}": ${e}');
            return null; // if gets error, return in null
        }
    }

    public static function getBytes(id:String):ByteArray
    {
        try {
            return openfl.utils.Assets.getBytes(id);
        } catch (e:Dynamic) {
            trace('Error in load bytes "${id}": ${e}');
            return null; // if gets error, return in null
        }
    }

	/**
     * List of all files of a directory in Internal Assets.
     * Example: AssetUtils.readDirectory("assets/songs/")
     */
    public static function readDirectory(prefix:String):Array<String>
    {
        var all = openfl.utils.Assets.list();
        var files = [];
        for (id in all)
        {
            if (id != null && id.indexOf(prefix) == 0)
                files.push(id);
        }
        return files;
    }

    public static function listFromPrefix(prefix:String):Array<String>
    {
        var all:Array<String> = openfl.utils.Assets.list();
        var filtered:Array<String> = [];
        for (id in all)
        {
            if (id != null && id.indexOf(prefix) == 0)
                filtered.push(id);
        }
        return filtered;
    }

    // example: var song:Array<String> = AssetUtils.listAssetsByType(AssetType.SOUND);
    public static function listAssetsByType(?type:AssetType):Array<String>
    {
        return openfl.utils.Assets.list(type);
    }

    // Example: var file:Array<String> = AssetUtils.listAssetsFromPrefix("assets/songs/");
    public static function listAssetsFromPrefix(prefix:String):Array<String>
    {
        var all = openfl.utils.Assets.list();
        var filtered = [];
        for (id in all)
            if (id != null && id.indexOf(prefix) == 0)
                filtered.push(id);
        return filtered;
    }

    // if the "asset" directory exists
    public static function isDirectory(prefix:String):Bool // old assetDirectoryExists
    {
        var all = openfl.utils.Assets.list();
        for (id in all)
            if (id != null && id.indexOf(prefix) == 0)
                return true;
        return false;
    }

    public static function absolutePath(fileName:String):String {
        #if sys
        try {
            return FileSystem.absolutePath(fileName);
        } catch(e:Dynamic) {

        }
        #end

        #if mobile
        return fileName;
        #else

        var pDir = "";
        var appDir = "file:///" + Sys.getCwd() + "/";
  
        if (fileName.indexOf(":") == -1)
            pDir = appDir;
        else if (fileName.indexOf("file://") == -1 && fileName.indexOf("http") == -1)
            pDir = "file:///";

        return pDir + fileName;
        #end
    }

    public static function getContent(id:String):String // old getAssetContent
    {
        if (Assets.exists(id)) {
            return Assets.getText(id);
        }
        return null;
    }

	//#if sys
	private static function createDirectory(path:String):Void
    {
        //#if mobile
        // are impossible create a directory internally because neededs be embed in the project
        //#else
		if (!Util.existsLOL(path)) {
			FileSystem.createDirectory(path);
		}
        //#end
	}

	/**
	 * Deletes a file or multiple files.
	 * @param path Path to the file or array of file paths.
	 */
	public static function deleteFile(path:Dynamic):Void
    {
        #if mobile
        // are impossible delete a file internally because are embed in the project
        #else
		if (Std.isOfType(path, String)) {
			if (Util.existsLOL(path)) {
				FileSystem.deleteFile(path);
			}
		} else if (Std.isOfType(path, Array)) {
			for (file in cast(path, Array<Dynamic>)) { // or can be: for (file in (cast path : Array<Dynamic>)) {
				if (Util.existsLOL(file)) {
					FileSystem.deleteFile(file);
				}
			}
		}
        #end
	}

	private static function saveContent(path:String, content:String):Void
    {
        //#if mobile
        // are impossible save a content internally because are embeded in the project
        //#else
		File.saveContent(path, content);
        //#end
	}
	//#end

    // ---- External Methods ----
    public static var path:String = lime.system.System.applicationStorageDirectory;

	public static function getPath(id:String, ?ext:String = "")
	{
		#if android
		var file = Assets.getBytes(id);

		var md5 = Md5.encode(Md5.make(file).toString());

		if (FileSystem.exists(path + md5 + ext))
			return path + md5 + ext;


		File.saveBytes(path + md5 + ext, file);

		return path + md5 + ext;
		#else
		return #if sys Sys.getCwd() + #end id;
		#end
	}

    // ---- Idklool Methods ----------------------------------------------

    // public static var path:String = System.applicationStorageDirectory;
  
    public static function getLOLContent(id:String):String // getContent
    {
        #if mobile
        return Assets.getText(id);
        #else
        return File.getContent(id);
        #end
    }
  
    public static function existsLOL(id:String):Bool // exists
    {
        #if mobile
        return Assets.exists(id);
        #else
        return FileSystem.exists(id);
        #end
    }
  
    public static function getLOLBytes(id:String) // getBytes
    {
        #if mobile
        return Assets.getBytes(id);
        #else
        return File.getBytes(id);
        #end
    }
  
    public static function readLOLDirectory(library:String):Array<String> // readDirectory
    {
        var something:Array<String> = [];
        #if mobile 
        for (folder in Assets.list().filter(text -> text != null && text.indexOf(library) >= 0))
        {
            if (folder != null && folder.charAt(0) != ".")
                something.push(folder);
        }
        return something;
        #else
        return FileSystem.readDirectory(library);
        #end
    }
  
    public static function fromLOLFile(id:String) // fromFile
    {
        #if mobile 
        return Assets.getBitmapData(id);
        #else
        return BitmapData.fromFile(id);
        #end
    }
  
    public static function getLOLPath(id:String, ?ext:String = "") // getPath
	{
		#if android
		var file = Assets.getBytes(id);

		var md5 = Md5.encode(Md5.make(file).toString());

		if (FileSystem.exists(path + md5 + ext))
			return path + md5 + ext;


		File.saveBytes(path + md5 + ext, file);

		return path + md5 + ext;
		#else
		return #if sys Sys.getCwd() + #end id;
		#end
	}

    // ----- Some Funny Functions --------------------------------------

    // Alternables to use Path.* of Haxetoolkit:
    /**
     * Gets the extension of the file
     * Ex: "filetext.txt" -> "txt"
     * Ex: "file.tar.gz" -> "gz"
     * Ex: "folder/file" -> ""
     * @param filePath the way of the path
     * @return the extension (without the end point), or one a null string if gets null.
     */
    public static function getExtension(filePath:String):String
    {
        #if mobile
        var lastDotIndex = filePath.lastIndexOf('.');
        if (lastDotIndex != -1 && lastDotIndex < filePath.length - 1) {
            return filePath.substring(lastDotIndex + 1);
        }
        return "";
        #else
        return Path.extension(filePath);
        #end
    }

    /**
     * Get the name of the file without the way, without the directory.
     * Ex: "way/for/the/file.txt" -> "file.txt"
     * Ex: "file.txt" -> "file.txt"
     * @param filePath the way of the path.
     * @return the file name (base), with the extension.
     */
    public static function getFileNameWithoutDirectory(filePath:String):String
    {
        #if mobile
        // Implemetion for mobile
        var lastSlashIndex = -1;
        #if windows
        lastSlashIndex = filePath.lastIndexOf('\\');
        #else
        lastSlashIndex = filePath.lastIndexOf('/');
        #end

        if (lastSlashIndex != -1) {
            return filePath.substring(lastSlashIndex + 1);
        }
        return filePath;
        #else
        // Implemention For desktop
        return Path.fileName(filePath);
        #end
    }

    /**
     * Return the file name with the way, without the extension.
     * Ex: "document.txt" -> "document"
     * Ex: "file.tar.gz" -> "file.tar"
     * Ex: "way/to/the/file" -> "file"
     * @param filePath the full way.
     * @return name of the file without the extension.
     */
    public static function getFileNameWithoutExtension(filePath:String):String
    {
        #if mobile
        // Implemention for mobile
        var fileName = getFileNameWithoutDirectory(filePath);
        var lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex != -1) {
            return fileName.substring(0, lastDotIndex);
        }
        return fileName;
        #else
        // for desktop
        // Path.withoutExtension returns the full way without the extension
        // So, neededs merge with Path.fileName for gets just the name.
        var fullPathWithoutExt = Path.withoutExtension(filePath);
        return Path.fileName(fullPathWithoutExt);
        #end
    }
    // ---- End of Util class ----
}
