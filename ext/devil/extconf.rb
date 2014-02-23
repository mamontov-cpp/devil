require 'mkmf'


if RUBY_PLATFORM =~ /mingw|win32/
    $libwinalikepath = RbConfig::CONFIG['includedir'].gsub(/\//, '\\').gsub(/include/,'lib\\')
    $CFLAGS += ' -I"' + RbConfig::CONFIG['includedir'] + '"'
    $LDFLAGS = $LDFLAGS + ' "' + $libwinalikepath + 'DevIL.lib"  "' + $libwinalikepath + 'ILU.lib" "'  + $libwinalikepath + 'DevIL.dll" "' + $libwinalikepath + 'ILU.dll" '	
	exit unless try_link("
	#include <IL/il.h>
	#include <IL/ilu.h>
	int main(int argc, char **argv) { ilInit(); iluInit(); return 0; }
	")
elsif RUBY_PLATFORM =~ /darwin/
    # this only works if you install devil via macports
    $CFLAGS += ' -I/opt/local/include/'
    $LDFLAGS += ' -L/opt/local/lib/'
    exit unless have_library("IL")
    exit unless have_library("ILU")
elsif RUBY_PLATFORM =~ /linux/
    exit unless have_library("IL")
    exit unless have_library("ILU")
end


create_makefile('devil')
