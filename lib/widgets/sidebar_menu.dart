import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Profile
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // Foto profil
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Welcome,',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      'User Name', // Ganti dengan nama user dinamis jika ada
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  icon: Icons.home,
                  text: 'Home',
                  onTap: () {
                    // Tambahkan navigasi ke Home
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.point_of_sale,
                  text: 'Kasir',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.inventory,
                  text: 'Kelola Produk',
                  onTap: () {
                    // Tambahkan navigasi ke Kelola Produk
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.history,
                  text: 'Riwayat Transaksi',
                  onTap: () {
                    // Navigasi ke Riwayat Transaksi
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.bar_chart,
                  text: 'Laporan',
                  onTap: () {
                    // Navigasi ke Laporan
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.settings,
                  text: 'Settings',
                  onTap: () {
                    // Navigasi ke Settings
                  },
                ),
              ],
            ),
          ),
          // Logout
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                // Tambahkan logika logout
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
