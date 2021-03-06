# This makefile creates the .h files in the parent directory from .lzz files here
LAZY=../tools/lzz -hx hh
RAWSOURCES=sdlStbFont.lzz example.lzz
OUTPUTDIR=../
TEMPDIR=temp/
SOURCES=$(addprefix $(TEMPDIR),$(RAWSOURCES:.lzz=.cpp))
SFI=$(addprefix $(OUTPUTDIR), $(RAWSOURCES:.lzz=.h))

all: $(SOURCES) $(SFI)
	mv ../example.h ../example.cpp

.PHONEY clean:
	rm -rf $(TEMPDIR)*

# Convert .lzz to .cpp and .hh
$(TEMPDIR)%.cpp $(TEMPDIR)%.hh: %.lzz
	mkdir -p $(TEMPDIR)$(dir $<)
	$(LAZY) -o $(TEMPDIR)$(dir $<) $<
		
# Concatenate the .cpp and .hh files into a single header
# and enable the SSF_IMPL macro
# then remove any instance of #include "filename.hh" that
# lzz has added
$(OUTPUTDIR)%.h: $(TEMPDIR)%.cpp $(TEMPDIR)%.hh
	echo '// This file is autogenerated. See look at the .lzz files in the src/ directory for a more human-friendly version' > $@
	cat $(TEMPDIR)$*.hh >> $@
	echo '' >> $@
	echo '////////////////////////////////////////////////////////////////////////' >> $@
	echo '' >> $@
	echo '#ifdef SDL_STB_FONT_IMPL' >> $@
	echo '#ifndef SDL_STB_FONT_IMPL_DOUBLE_GUARD_$(subst /,_,$(subst \\,_,$*))' >> $@
	echo '#define SDL_STB_FONT_IMPL_DOUBLE_GUARD_$(subst /,_,$(subst \\,_,$*))' >> $@
	cat $(TEMPDIR)$*.cpp >> $@
	echo '#endif //SDL_STB_FONT_IMPL_DOUBLE_GUARD_$(subst /,_,$(subst \\,_,$*))' >> $@
	echo '#endif //SDL_STB_FONT_IMPL_IMPL' >> $@
	sed -i '/#include ".*\.hh"/d' $@ 

