class String
  # Converts a string into a deterministic, readable CSS hexadecimal color.
  #
  # The method generates a CRC32 hash from the string and extracts RGB values,
  # then adjusts contrast to ensure good readability (avoiding colors that are too dark or too light).
  #
  # @return [String] A CSS hex color string in the format "#RRGGBB"
  #
  # @example Basic usage
  #   "hello".to_rgb
  #   # => "#10A686"
  def to_rgb
    hash = Zlib.crc32(self)

    red = (hash >> 16) & 0xFF
    green = (hash >> 8) & 0xFF
    blue = hash & 0xFF

    red, green, blue = adjust_contrast(red, green, blue)

    format('#%<r>02X%<g>02X%<b>02X', r: red, g: green, b: blue)
  end

  private

  def adjust_contrast(red, green, blue)
    # Compute perceived luminance (WCAG formula)
    luminance = (0.2126 * red) + (0.7152 * green) + (0.0722 * blue)

    if luminance < 64
      # Too dark → lighten
      red = [red + 60, 255].min
      green = [green + 60, 255].min
      blue = [blue + 60, 255].min
    elsif luminance > 200
      # Too light → darken
      red = [red - 60, 0].max
      green = [green - 60, 0].max
      blue = [blue - 60, 0].max
    end

    [red, green, blue]
  end
end
