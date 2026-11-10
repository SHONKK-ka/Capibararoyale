ifeq ($(strip $(DEVKITPRO)),)
$(error "Falta DEVKITPRO")
endif

include $(DEVKITPRO)/wut/share/wut_rules

.RECIPEPREFIX := >
.DEFAULT_GOAL := all

TARGET   := CapibaraRoyale
BUILD    := build
SOURCES  := src
CONTENT  := activos
PORTLIBS := $(DEVKITPRO)/portlibs/wiiu
PPC      := $(DEVKITPRO)/devkitPPC/bin/powerpc-eabi-
CC       := $(PPC)gcc
CXX      := $(PPC)g++

CFLAGS   := -g -O2 -Wall $(MACHDEP) -D__WIIU__ \
            -I$(WUT_ROOT)/include -I$(PORTLIBS)/include \
            -I$(PORTLIBS)/include/SDL2 -I$(SOURCES)
CXXFLAGS := $(CFLAGS) -std=c++17
LDFLAGS  := -g $(MACHDEP) $(WUT_NEWLIB_LDFLAGS) $(WUT_STDCPP_LDFLAGS) \
            -L$(PORTLIBS)/lib -L$(WUT_ROOT)/lib \
            -lSDL2_mixer -lSDL2_image -lSDL2 -lwut -lm

CFILES   := $(notdir $(wildcard $(SOURCES)/*.c))
CPPFILES := $(notdir $(wildcard $(SOURCES)/*.cpp))
OFILES   := $(addprefix $(BUILD)/,$(CPPFILES:.cpp=.o) $(CFILES:.c=.o))

.PHONY: all clean

all: $(BUILD)/$(TARGET).wuhb

$(BUILD):
> @mkdir -p $@

$(BUILD)/%.o: $(SOURCES)/%.c | $(BUILD)
> $(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/%.o: $(SOURCES)/%.cpp | $(BUILD)
> $(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD)/$(TARGET).elf: $(OFILES)
> $(CXX) $(OFILES) $(LDFLAGS) -o $@

$(BUILD)/$(TARGET).rpx: $(BUILD)/$(TARGET).elf
> elf2rpl $< $@

$(BUILD)/$(TARGET).wuhb: $(BUILD)/$(TARGET).rpx
> wuhbtool $< $@ --name="Capibara Royale" --short-name="Capibara Royale" \
>   --author="Capibara" --icon=icon.png \
>   $(if $(wildcard $(CONTENT)),--content=$(CONTENT),)

clean:
> rm -rf $(BUILD)
