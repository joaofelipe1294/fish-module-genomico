module FileManager

  def load_files
    @blue = File.open(@image_data["channels"]["blue"])
    @green = File.open(@image_data["channels"]["green"])
    @red = File.open(@image_data["channels"]["red"])
    @blue_green = File.open(@image_data["channels"]["blue-green"])
    @blue_red = File.open(@image_data["channels"]["blue-red"])
    @green_red = File.open(@image_data["channels"]["green-red"])
  end

  def close_files
    @blue.close
    @green.close
    @red.close
    @blue_green.close
    @blue_red.close
    @green_red.close
  end

  def purge_files
    File.delete(@image_data["channels"]["blue"])
    File.delete(@image_data["channels"]["green"])
    File.delete(@image_data["channels"]["red"])
    File.delete(@image_data["channels"]["blue-green"])
    File.delete(@image_data["channels"]["blue-red"])
    File.delete(@image_data["channels"]["green-red"])
  end

end
