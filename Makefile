# The order of the sources does matter.
SOURCES := src/requires.moon
SOURCES += src/log.moon
SOURCES += src/settings.moon
SOURCES += src/Stack.moon
SOURCES += src/Window.moon
SOURCES += src/Mouse.moon
SOURCES += src/Rect.moon
SOURCES += src/ActivityZone.moon
SOURCES += src/AnimationQueue.moon
SOURCES += src/EventLoop.moon
SOURCES += src/Animation.moon
SOURCES += src/UIElement.moon
SOURCES += src/BarAccent.moon
SOURCES += src/BarBase.moon
SOURCES += src/ProgressBar.moon
SOURCES += src/ProgressBarCache.moon
SOURCES += src/ProgressBarBackground.moon
SOURCES += src/ChapterMarker.moon
SOURCES += src/Chapters.moon
SOURCES += src/TimeElapsed.moon
SOURCES += src/TimeRemaining.moon
SOURCES += src/HoverTime.moon
SOURCES += src/PauseIndicator.moon
SOURCES += src/Title.moon
SOURCES += src/SystemTime.moon
SOURCES += src/main.moon

TMPDIR    := build
JOINEDSRC := $(TMPDIR)/progressbar.moon
OUTPUT    := $(JOINEDSRC:.moon=.lua)
RESULTS   := $(addprefix $(TMPDIR)/, $(SOURCES:.moon=.lua))

.PHONY: all clean

all: $(OUTPUT)

$(OUTPUT): $(JOINEDSRC) $(RESULTS)
	@moonc -o $@ $<

$(JOINEDSRC): $(SOURCES) | $(TMPDIR)
	@cat $^ > $@

$(RESULTS): | $(TMPDIR)/src/
$(TMPDIR)/%.lua: %.moon
	@moonc -o $@ $<

$(TMPDIR):
	@mkdir -p $@

$(TMPDIR)/%/: | $(TMPDIR)
	@mkdir -p $@

clean:
	@rm -rf $(TMPDIR)
