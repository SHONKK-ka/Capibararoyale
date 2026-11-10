# Capibara Royale - Makefile FIJO para flujo de trabajo (puntico verde)

ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO")
endif

TOPDIR ?= $(CURDIR)

include $(DEVKITPRO)/wut/share/wut_rules

TARGET := CapibaraRoyale
BUILD := build
SOURCES := src
DATA := activos
INCLUDES := src

# Flags simples sin sdl2-config para evitar permission denied
CFLAGS := -g -O2 -Wall -D__WIIU__ -I$(PORTLIBS)/include -I$(PORTLIBS)/include/SDL2 -I$(INCLUDES)
CXXFLAGS := $(CFLAGS) -std=c++17
LDFLAGS := -g $(WUT_NEWLIB_LDFLAGS) $(WUT_STDCPP_LDFLAGS) -L$(PORTLIBS)/lib -lSDL2 -lSDL2_mixer -lSDL2_image -lm

CFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
OFILES := $(CPPFILES:.cpp=.o) $(CFILES:.c=.o)

# Si no hay src, busca en raiz
ifeq ($(strip $(CPPFILES)),)
CPPFILES := $(notdir $(wildcard *.cpp))
CFILES := $(notdir $(wildcard *.c))
SOURCES := .
OFILES := $(CPPFILES:.cpp=.o) $(CFILES:.c=.o)
endif

include $(DEVKITPRO)/wut/share/wut_rules

$(BUILD):
	@mkdir -p $@

$(shell chmod -R 755 $(PORTLIBS)/bin 2>/dev/null || true)
