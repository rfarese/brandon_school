module TmpAide
  def path(file_name)
    @tmp_path = Rails.root.join('tmp', file_name)
  end

  def tmp_path
    @tmp_path
  end

  def open_file
    File.open(tmp_path) { |file| return file }
  end

  def remove_file
    File.delete(tmp_path)
  end
end
