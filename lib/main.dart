import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.light,
        ),
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 1;

  // Data Profil
  String _name = 'Zaki R';
  String _bio = 'Mobile Developer Enthusiast';
  String? _imagePath;
  String _about = 'Saya adalah manusia';
  String _education = 'Universitas Geger Kalong';
  String _hobby = 'ngomongin kurs rupiah';
  String _skills = 'Cuci motor pake Ai';
  String _email = 'zakiwijaya63@gmail.com';
  String _phone = '+62 0821567488';
  String _location = 'Bandung, Jawa Barat';

  // Data Pengalaman
  String _expTitle = 'test';
  String _expDesc = 'test';
  String? _expImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                'Menu Utama',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.work),
              title: const Text('Edit Pengalaman'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditExperiencePage(
                      initialData: {
                        'expTitle': _expTitle,
                        'expDesc': _expDesc,
                        'expImagePath': _expImagePath ?? '',
                      },
                    ),
                  ),
                );
                if (result != null && mounted) {
                  setState(() {
                    _expTitle = result['expTitle'];
                    _expDesc = result['expDesc'];
                    _expImagePath = result['expImagePath'].isEmpty ? null : result['expImagePath'];
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const GalleryHome()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Pengaturan'),
                    content: const Text('Fitur pengaturan belum tersedia.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
                    ],
                  ),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.info),
              title: Text('Tentang'),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _imagePath != null
                        ? (kIsWeb ? NetworkImage(_imagePath!) : FileImage(File(_imagePath!))) as ImageProvider
                        : const NetworkImage('https://avatars.githubusercontent.com/u/1?v=4'),
                  ),
                  const SizedBox(height: 12),
                  Text(_name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(_bio, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(child: _StatBox(label: 'Post', value: '12')),
                Expanded(child: _StatBox(label: 'Followers', value: '226k')),
                Expanded(child: _StatBox(label: 'Following', value: '450')),
              ],
            ),

            const SizedBox(height: 24),
            _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content: _about,
            ),
            _SectionCard(
              icon: Icons.school_outlined,
              title: 'Pendidikan',
              content: _education,
            ),
            _SectionCard(
              icon: Icons.favorite_outline,
              title: 'Hobi & Minat',
              content: _hobby,
            ),
            _SectionCard(
              icon: Icons.star_outline,
              title: 'Skills',
              contentWidget: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _skills.split(',').map((skill) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(skill.trim(), style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                )).toList(),
              ),
            ),
            _SectionCard(
              icon: Icons.layers_outlined,
              title: 'Pengalaman',
              trailing: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Color(0xFFF3E5F5), shape: BoxShape.circle),
                child: const Text('1', style: TextStyle(fontSize: 10, color: Colors.blueAccent)),
              ),
              contentWidget: Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _expImagePath != null
                          ? (kIsWeb
                              ? Image.network(_expImagePath!, width: 60, height: 60, fit: BoxFit.cover)
                              : Image.file(File(_expImagePath!), width: 60, height: 60, fit: BoxFit.cover))
                          : Container(width: 60, height: 60, color: Colors.grey.shade300, child: const Icon(Icons.image)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_expTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 2),
                          Text(_expDesc, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _SectionCard(
              icon: Icons.email_outlined,
              title: 'Kontak',
              content: '$_email\n$_phone',
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfilePage(
                initialData: {
                  'name': _name,
                  'bio': _bio,
                  'imagePath': _imagePath ?? '',
                  'about': _about,
                  'education': _education,
                  'hobby': _hobby,
                  'skills': _skills,
                  'email': _email,
                  'phone': _phone,
                  'location': _location,
                  'expTitle': _expTitle,
                  'expDesc': _expDesc,
                  'expImagePath': _expImagePath ?? '',
                },
              ),
            ),
          );
          if (result != null && mounted) {
            setState(() {
              _name = result['name'];
              _bio = result['bio'];
              _imagePath = result['imagePath'].isEmpty ? null : result['imagePath'];
              _about = result['about'];
              _education = result['education'];
              _hobby = result['hobby'];
              _skills = result['skills'];
              _email = result['email'];
              _phone = result['phone'];
              _location = result['location'];
              _expTitle = result['expTitle'];
              _expDesc = result['expDesc'];
              _expImagePath = result['expImagePath'].isEmpty ? null : result['expImagePath'];
            });
          }
        },
        label: const Text('Edit Profil'),
        icon: const Icon(Icons.edit),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
          NavigationDestination(icon: Icon(Icons.message), label: 'Pesan'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? content;
  final Widget? contentWidget;
  final Widget? trailing;

  const _SectionCard({required this.icon, required this.title, this.content, this.contentWidget, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepPurple.shade400, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                if (trailing != null) trailing!,
              ],
            ),
            if (content != null || contentWidget != null)
              Padding(
                padding: const EdgeInsets.only(left: 32, top: 4),
                child: content != null
                    ? Text(content!, style: TextStyle(fontSize: 13, color: Colors.grey.shade600))
                    : contentWidget!,
              ),
          ],
        ),
      ),
    );
  }
}

class EditExperiencePage extends StatefulWidget {
  final Map<String, String> initialData;
  const EditExperiencePage({super.key, required this.initialData});
  @override
  State<EditExperiencePage> createState() => _EditExperiencePageState();
}

class _EditExperiencePageState extends State<EditExperiencePage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late String? _selectedImagePath;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialData['expTitle']);
    _descController = TextEditingController(text: widget.initialData['expDesc']);
    _selectedImagePath = widget.initialData['expImagePath']!.isEmpty ? null : widget.initialData['expImagePath'];
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _selectedImagePath = image.path);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Pengalaman'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context, {
              'expTitle': _titleController.text,
              'expDesc': _descController.text,
              'expImagePath': _selectedImagePath ?? '',
            }),
            icon: const Icon(Icons.save_outlined, size: 18),
            label: const Text('Simpan'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E5F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.deepPurple.shade100),
                ),
                child: _selectedImagePath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: kIsWeb ? Image.network(_selectedImagePath!, fit: BoxFit.cover) : Image.file(File(_selectedImagePath!), fit: BoxFit.cover))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_photo_alternate_outlined, size: 48, color: Colors.deepPurple.shade300),
                          const SizedBox(height: 8),
                          Text('Ketuk untuk pilih gambar', style: TextStyle(color: Colors.deepPurple.shade400, fontWeight: FontWeight.w500)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Informasi Pengalaman', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Judul *', prefixIcon: const Icon(Icons.text_fields), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'Deskripsi', prefixIcon: const Padding(padding: EdgeInsets.only(bottom: 80), child: Icon(Icons.description_outlined)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, {'expTitle': _titleController.text, 'expDesc': _descController.text, 'expImagePath': _selectedImagePath ?? ''}),
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text('Simpan Pengalaman', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5E548E), minimumSize: const Size.fromHeight(50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final Map<String, String> initialData;
  const EditProfilePage({super.key, required this.initialData});
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController, _bioController, _aboutController, _eduController, _hobbyController, _skillsController, _emailController, _phoneController, _locationController, _expTitleController, _expDescController;
  late String? _selectedImagePath, _selectedExpImagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialData['name']);
    _bioController = TextEditingController(text: widget.initialData['bio']);
    _aboutController = TextEditingController(text: widget.initialData['about']);
    _eduController = TextEditingController(text: widget.initialData['education']);
    _hobbyController = TextEditingController(text: widget.initialData['hobby']);
    _skillsController = TextEditingController(text: widget.initialData['skills']);
    _emailController = TextEditingController(text: widget.initialData['email']);
    _phoneController = TextEditingController(text: widget.initialData['phone']);
    _locationController = TextEditingController(text: widget.initialData['location']);
    _expTitleController = TextEditingController(text: widget.initialData['expTitle']);
    _expDescController = TextEditingController(text: widget.initialData['expDesc']);
    _selectedImagePath = widget.initialData['imagePath']!.isEmpty ? null : widget.initialData['imagePath'];
    _selectedExpImagePath = widget.initialData['expImagePath']!.isEmpty ? null : widget.initialData['expImagePath'];
  }

  Future<void> _pickImage(bool isProfile) async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => isProfile ? _selectedImagePath = image.path : _selectedExpImagePath = image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil'), actions: [IconButton(icon: const Icon(Icons.save), onPressed: _save)]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 60, backgroundImage: _selectedImagePath != null ? (kIsWeb ? NetworkImage(_selectedImagePath!) : FileImage(File(_selectedImagePath!))) as ImageProvider : const NetworkImage('https://avatars.githubusercontent.com/u/1?v=4')),
            TextButton.icon(onPressed: () => _pickImage(true), icon: const Icon(Icons.camera_alt), label: const Text('Ganti Foto Profil')),
            _buildField(_nameController, 'Nama Lengkap', Icons.person),
            _buildField(_bioController, 'Bio', Icons.info),
            _buildField(_aboutController, 'Tentang Saya', Icons.description, maxLines: 3),
            _buildField(_eduController, 'Pendidikan', Icons.school),
            _buildField(_locationController, 'Lokasi', Icons.location_on),
            _buildField(_emailController, 'Email', Icons.email),
            _buildField(_phoneController, 'Nomor Telepon', Icons.phone),
            _buildField(_skillsController, 'Skills', Icons.star),
            const Divider(),
            const Text('Edit Pengalaman', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildField(_expTitleController, 'Judul Pengalaman', Icons.title),
            _buildField(_expDescController, 'Deskripsi Pengalaman', Icons.notes, maxLines: 2),
            ElevatedButton(onPressed: _save, child: const Text('Simpan Perubahan')),
          ],
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label, IconData icon, {int maxLines = 1}) {
    return Padding(padding: const EdgeInsets.only(bottom: 16), child: TextField(controller: controller, maxLines: maxLines, decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon))));
  }

  void _save() {
    Navigator.pop(context, {
      'name': _nameController.text, 'bio': _bioController.text, 'imagePath': _selectedImagePath ?? '',
      'about': _aboutController.text, 'education': _eduController.text, 'hobby': _hobbyController.text,
      'skills': _skillsController.text, 'email': _emailController.text, 'phone': _phoneController.text,
      'location': _locationController.text, 'expTitle': _expTitleController.text, 'expDesc': _expDescController.text,
      'expImagePath': _selectedExpImagePath ?? '',
    });
  }
}

class GalleryHome extends StatelessWidget {
  const GalleryHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Widget Gallery')), body: const Center(child: Text('Gallery Home')));
  }
}
