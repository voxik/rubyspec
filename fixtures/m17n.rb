m17n_strings_folder = File.join(File.dirname(__FILE__), File.basename(__FILE__, ".rb"))

Dir[File.join(m17n_strings_folder, "*.rb")].each {|file| require file}
