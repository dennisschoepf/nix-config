function resize_images --description "Resize all JPG images in current directory and subdirectories to 40% of original size"
    if not command -q convert
        echo "Error: ImageMagick is not installed. Please install it first."
        return 1
    end

    for img in (find . -type f -name "*.JPG")
        set original_size (stat -f %z "$img")
        convert "$img" -resize 40% "$img"
        set new_size (stat -f %z "$img")
        echo "Processed $img"
        echo "Original size: $original_size bytes"
        echo "New size: $new_size bytes"
        echo "---"
    end
end
