import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../../main.dart'; // For client
import '../../../../config/palette.dart';
import '../../../../widgets/widgets.dart';

class DocumentationSettings extends StatefulWidget {
  const DocumentationSettings({super.key});

  @override
  State<DocumentationSettings> createState() => _DocumentationSettingsState();
}

class _DocumentationSettingsState extends State<DocumentationSettings> {
  SystemVariables? variables;
  List<FontSetting> fontSettings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      final data = await client.admin.getSystemVariables();
      final fonts = await client.admin.getFontSettings();
      print('DocumentationSettings: Fetched variables. tabPreset1: ${data?.tabPreset1}, tabPreset2: ${data?.tabPreset2}');
      setState(() {
        variables = data ?? SystemVariables(
          punchingMode: 'manual', 
          lineHeight: 1.5,
          processWidth: 150,
          conditionWidth: 120,
          terminalWidth: 100,
          allowEdit: true,
          showEdit: true,
          allowDelete: true,
          showDelete: true,
        );
        fontSettings = fonts;
        fontSettings.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching system variables: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _save() async {
    if (variables == null) return;
    try {
      print('DocumentationSettings: Saving variables. tabPreset1: ${variables!.tabPreset1}, tabPreset2: ${variables!.tabPreset2}');
      await client.admin.updateSystemVariables(variables!);
    } catch (e) {
      debugPrint("Error saving system variables: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Documentation Settings",
          style: TextStyle(fontSize: 16, color: Pallet.font3),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTabSwitchingSection(),
                      const SizedBox(width: 20),
                      _buildAvailableFontsSection(),
                      const SizedBox(width: 20),
                      _buildFlowChartSection(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildFontSettingsSection(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTabSwitchingSection() {
    final available = fontSettings.map((f) => f.name.toLowerCase()).toList();
    if (available.isEmpty) available.add('body');
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "document presets",
          style: TextStyle(fontSize: 16, color: Pallet.font3),
        ),
        const SizedBox(height: 10),
        GlassMorph(
          width: 280,
          padding: const EdgeInsets.all(15),
          borderRadius: 10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("tab presets", style: TextStyle(fontSize: 13)),
                  Text("document", style: TextStyle(color: Pallet.font3.withValues(alpha: 0.5), fontSize: 12)),
                ],
              ),
              const SizedBox(height: 10),
              _buildFontDropdownRow("preset 1", (variables!.tabPreset1 ?? 'heading').toLowerCase(), available, (val) {
                setState(() => variables!.tabPreset1 = val.toLowerCase());
                _save();
              }),
              const SizedBox(height: 10),
              _buildFontDropdownRow("preset 2", (variables!.tabPreset2 ?? 'body').toLowerCase(), available, (val) {
                setState(() => variables!.tabPreset2 = val.toLowerCase());
                _save();
              }),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("header levels", style: TextStyle(fontSize: 13)),
                  Text("font", style: TextStyle(color: Pallet.font3.withValues(alpha: 0.5), fontSize: 12)),
                ],
              ),
              const SizedBox(height: 10),
              _buildFontDropdownRow("h1", (variables!.titleFont ?? 'title').toLowerCase(), available, (val) {
                setState(() => variables!.titleFont = val.toLowerCase());
                _save();
              }),
              const SizedBox(height: 10),
              _buildFontDropdownRow("h2", (variables!.headingFont ?? 'heading').toLowerCase(), available, (val) {
                setState(() => variables!.headingFont = val.toLowerCase());
                _save();
              }),
              const SizedBox(height: 10),
              _buildFontDropdownRow("h3", (variables!.subHeadingFont ?? 'sub heading').toLowerCase(), available, (val) {
                setState(() => variables!.subHeadingFont = val.toLowerCase());
                _save();
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFontDropdownRow(String label, String value, List<String> items, Function(String) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Pallet.font3,
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 150,
          child: DropDown(
            label: value,
            items: items,
            itemKey: "", // Not needed for List<String>
            onPress: (val) {
              onChanged(val.toString());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFlowChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("flow charts"),
        const SizedBox(height: 10),
        GlassMorph(
          width: 250,
          padding: const EdgeInsets.all(15),
          borderRadius: 10,
          child: Column(
            children: [
              _buildInputRow("Process Width", (variables!.processWidth ?? 150).toString(), (val) {
                setState(() => variables!.processWidth = double.tryParse(val) ?? variables!.processWidth);
                _save();
              }),
              const SizedBox(height: 10),
              _buildInputRow("Condition Width", (variables!.conditionWidth ?? 120).toString(), (val) {
                setState(() => variables!.conditionWidth = double.tryParse(val) ?? variables!.conditionWidth);
                _save();
              }),
              const SizedBox(height: 10),
              _buildInputRow("Terminal Width", (variables!.terminalWidth ?? 100).toString(), (val) {
                setState(() => variables!.terminalWidth = double.tryParse(val) ?? variables!.terminalWidth);
                _save();
              }),
              const SizedBox(height: 10),
              _buildInputRow("Line Height", (variables!.lineHeight ?? 1.5).toString(), (val) {
                setState(() => variables!.lineHeight = double.tryParse(val) ?? variables!.lineHeight);
                _save();
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFontSettingsSection() {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            const Text("document presets"),
            SmallButton(
              label: "add preset",
              onPress: () => _showFontSettingDialog(null),
            ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: fontSettings.isEmpty
                    ? [
                        const Text("No presets yet",
                            style: TextStyle(fontSize: 12, color: Colors.grey))
                      ]
              : fontSettings.map((font) => _buildFontSettingCard(font)).toList(),
        ),
      ],
    );
  }

  Widget _buildAvailableFontsSection() {
    final available = variables?.googleFonts ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("available fonts"),
        const SizedBox(height: 10),
        GlassMorph(
          width: 250,
          height: 250,
          padding: const EdgeInsets.all(10),
          borderRadius: 10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("variables", style: TextStyle(fontSize: 13)),
                  AddButton(onPress: _showGoogleFontsSearchDialog),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: available.isEmpty
                    ? const Center(
                        child: Text("No custom fonts added",
                            style: TextStyle(fontSize: 12, color: Colors.grey)))
                    : SingleChildScrollView(
                        child: Column(
                          children: available
                              .map((font) => _buildAvailableFontCard(font))
                              .toList(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableFontCard(String font) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: GlassMorph(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        borderRadius: 5,
        color: Pallet.inside1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                font,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: font, // Try to apply it
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  variables!.googleFonts!.remove(font);
                });
              },
              child: const Icon(Icons.delete, size: 14, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showGoogleFontsSearchDialog() {
    final searchController = TextEditingController();
    List<String> filteredFonts = List.from(_allGoogleFonts);
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text("Search Google Fonts"),
            content: SizedBox(
              width: 400,
              height: 500,
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Search fonts...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (val) {
                      setDialogState(() {
                        filteredFonts = _allGoogleFonts
                            .where((f) => f.toLowerCase().contains(val.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredFonts.length,
                      itemBuilder: (context, index) {
                        final font = filteredFonts[index];
                        final isAdded = variables?.googleFonts?.contains(font) ?? false;
                        
                        return ListTile(
                          title: Text(
                            font,
                            style: TextStyle(fontFamily: font),
                          ),
                          trailing: isAdded
                              ? const Icon(Icons.check, color: Colors.green)
                              : const Icon(Icons.add),
                          onTap: isAdded ? null : () {
                            setState(() {
                              variables!.googleFonts ??= [];
                              if (!variables!.googleFonts!.contains(font)) {
                                variables!.googleFonts!.add(font);
                              }
                            });
                            setDialogState(() {});
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          );
        },
      ),
    );
  }

  static const List<String> _allGoogleFonts = [
    'Roboto', 'Open Sans', 'Lato', 'Montserrat', 'Poppins', 'Source Sans Pro', 
    'Roboto Condensed', 'Oswald', 'Roboto Mono', 'Raleway', 'Inter', 'Noto Sans', 
    'Mukta', 'Ubuntu', 'Playfair Display', 'Lora', 'PT Sans', 'Nunito', 'Roboto Slab', 
    'Merriweather', 'PT Serif', 'Open Sans Condensed', 'Kanit', 'Titillium Web', 
    'Heebo', 'Muli', 'Nunito Sans', 'Quicksand', 'Fira Sans', 'Libre Franklin', 
    'Inconsolata', 'Oxygen', 'Josefin Sans', 'Work Sans', 'Anton', 'Arimo', 'Karla', 
    'Dosis', 'Hind', 'Cabin', 'Abel', 'Crimson Text', 'Bitter', 'Lobster', 
    'PT Sans Narrow', 'Dancing Script', 'Pacifico', 'Exo 2', 'Questrial', 
    'Shadows Into Light', 'Fjalla One', 'Caveat', 'Source Code Pro', 'Indie Flower', 
    'Arvo', 'Crimson Pro', 'Merriweather Sans', 'Ubuntu Condensed', 'Catamaran', 
    'Signika', 'Bree Serif', 'Play', 'Rubik', 'Comfortaa', 'Domine', 'Asap', 
    'Patua One', 'Maven Pro', 'Assistant', 'Archivo Narrow', 'Acme', 'Satisfy', 
    'Yellowtail', 'EB Garamond', 'Courgette', 'Josefin Slab', 'Volkhov', 'Rokkitt', 
    'Kalam', 'Righteous', 'Philosopher', 'Fredoka One', 'Concert One', 'Russo One', 
    'Architects Daughter', 'Orbitron', 'Exo', 'Lobster Two', 'Cookie', 'Khand', 
    'Vollkorn', 'Amatic SC', 'Bricolage Grotesque', 'Figtree', 'Gelasio', 
    'Hanken Grotesque', 'Instrument Sans', 'Jura', 'Kumbh Sans', 
    'League Spartan', 'Lexend', 'Manrope', 'Onest', 'Outfit', 'Plus Jakarta Sans', 
    'Public Sans', 'Red Hat Display', 'Schibsted Grotesque', 'Sen', 'Sora', 
    'Space Grotesque', 'Syne', 'Urbanist'
  ];

  Widget _buildFontSettingCard(FontSetting font) {
    return GlassMorph(
      width: 250,
      padding: const EdgeInsets.all(10),
      borderRadius: 5,
      color: Pallet.inside1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  font.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => _showFontSettingDialog(font),
                    child: const Icon(Icons.edit, size: 16),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      await client.admin.deleteFontSetting(font.id!);
                      _fetchData();
                    },
                    child: const Icon(Icons.delete, size: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("Size: ", style: TextStyle(fontSize: 12, color: Colors.grey)),
              FontSizeEditor(
                initialSize: font.fontSize ?? 14.0,
                onSizeChanged: (newSize) async {
                  font.fontSize = newSize;
                  await client.admin.saveFontSetting(font);
                  _fetchData();
                },
              ),
              const SizedBox(width: 8),
              AppColorPicker(
                initialColor: font.color,
                onColorChanged: (hex) async {
                  font.color = hex;
                  await client.admin.saveFontSetting(font);
                  _fetchData();
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FontFamilySearchDropdown(
                value: font.fontFamily ?? 'Roboto',
                items: variables?.googleFonts ?? ['Roboto', 'Montserrat', 'Lato'],
                onChanged: (newFamily) async {
                  font.fontFamily = newFamily;
                  await client.admin.saveFontSetting(font);
                  _fetchData();
                },
              ),
              const SizedBox(width: 8),
              DocumentDropdown(
                value: font.fontWeight ?? 'normal',
                items: const [
                  'normal', 'bold', 'w100', 'w200', 'w300', 'w400', 
                  'w500', 'w600', 'w700', 'w800', 'w900'
                ],
                onChanged: (newWeight) async {
                  font.fontWeight = newWeight;
                  await client.admin.saveFontSetting(font);
                  _fetchData();
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text("Line Height: ", style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(
                width: 80,
                child: SmallTextBox(
                  controller: TextEditingController(text: (font.lineHeight ?? 1.5).toString()),
                  onType: (value) async {
                    if (value.isEmpty) return;
                    final newLineHeight = double.tryParse(value);
                    if (newLineHeight != null && newLineHeight > 0) {
                      font.lineHeight = newLineHeight;
                      await client.admin.saveFontSetting(font);
                      _fetchData();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFontSettingDialog(FontSetting? font) {
    final nameController = TextEditingController(text: font?.name ?? '');
    final sizeController = TextEditingController(text: font?.fontSize?.toString() ?? '');
    final familyController = TextEditingController(text: font?.fontFamily ?? '');
    final weightController = TextEditingController(text: font?.fontWeight ?? '');
    final colorController = TextEditingController(text: font?.color ?? '');
    final lineHeightController = TextEditingController(text: font?.lineHeight?.toString() ?? '');
    int selectedHeaderLevel = font?.headerLevel ?? 0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(font == null ? "Add Font Setting" : "Edit Font Setting"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: sizeController,
                  decoration: const InputDecoration(labelText: "Font Size"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: familyController,
                  decoration: const InputDecoration(labelText: "Font Family"),
                ),
                TextField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: "Font Weight (e.g., bold, normal)"),
                ),
                TextField(
                  controller: colorController,
                  decoration: const InputDecoration(labelText: "Color (hex)"),
                ),
                TextField(
                  controller: lineHeightController,
                  decoration: const InputDecoration(labelText: "Line Height (e.g., 1.5)"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<int>(
                  value: selectedHeaderLevel,
                  decoration: const InputDecoration(labelText: "Header Level"),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text("Body / Paragraph")),
                    DropdownMenuItem(value: 1, child: Text("H1")),
                    DropdownMenuItem(value: 2, child: Text("H2")),
                    DropdownMenuItem(value: 3, child: Text("H3")),
                  ],
                  onChanged: (val) {
                    if (val != null) {
                      setDialogState(() {
                        selectedHeaderLevel = val;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final setting = FontSetting(
                  id: font?.id,
                  name: nameController.text,
                  fontSize: double.tryParse(sizeController.text),
                  fontFamily: familyController.text.isEmpty ? null : familyController.text,
                  fontWeight: weightController.text.isEmpty ? null : weightController.text,
                  color: colorController.text.isEmpty ? null : colorController.text,
                  lineHeight: double.tryParse(lineHeightController.text),
                  headerLevel: selectedHeaderLevel,
                );
                await client.admin.saveFontSetting(setting);
                _fetchData();
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputRow(String label, String value, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 5),
        SmallTextBox(
          controller: TextEditingController(text: value),
          onEnter: onChanged,
        ),
      ],
    );
  }
}
