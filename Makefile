# Capibara Royale Wii U - Makefile para compilar desde celular con GitHub Codespaces
# Requiere devkitPro con wut y SDL2

ifeq ($(strip $(DEVKITPRO)),)
$(error "Please set DEVKITPRO in your environment. En Codespaces usa el Dockerfile con devkitPro")
endif

TOPDIR ?= $(CURDIR)
include $(DEVKITPRO)/wut/share/wut_rules

TARGET := CapibaraRoyale
BUILD := build
SOURCES := src
DATA := assets
INCLUDES := src

CFLAGS := -g -O2 -Wall -I$(INCLUDES) $(shell $(PORTLIBS)/bin/sdl2-config --cflags)
CXXFLAGS := $(CFLAGS) -std=c++17
LDFLAGS := -g $(WUT_NEWLIB_LDFLAGS) $(WUT_STDCPP_LDFLAGS) $(shell $(PORTLIBS)/bin/sdl2-config --libs) -lSDL2_mixer -lSDL2_image -lSDL2_ttf -lm

CFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
OFILES := $(addsuffix .o,$(BINFILES)) $(CPPFILES:.cpp=.o) $(CFILES:.c=.o)

# wuhb
include $(DEVKITPRO)/wut/share/wut_rules

# Para compilar: make
# Genera: CapibaraRoyale.wuhb
