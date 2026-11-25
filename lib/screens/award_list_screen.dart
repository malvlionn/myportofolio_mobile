import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/award.dart';
import 'package:myportofolio_mobile/screens/award_detail_screen.dart';
import 'package:myportofolio_mobile/screens/award_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class AwardListScreen extends StatefulWidget {
  const AwardListScreen({super.key});

  @override
  State<AwardListScreen> createState() => _AwardListScreenState();
}

class _AwardListScreenState extends State<AwardListScreen> {
  late Future<List<Award>> _awardsFuture;

  @override
  void initState() {
    super.initState();
    _awardsFuture = context.read<ApiClient>().getAwards();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getAwards();
    setState(() {
      _awardsFuture = future;
    });
    await future;
  }

  Future<void> _openCreateForm() async {
    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;
    final created = await Navigator.push<Award>(
      context,
      MaterialPageRoute(builder: (_) => const AwardFormPage()),
    );
    if (created != null && mounted) {
      await _reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awards & Achievements'),
        actions: [
          IconButton(
            tooltip: 'Tambah Penghargaan',
            onPressed: _openCreateForm,
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Award>>(
        future: _awardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Failed to load awards: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final awards = snapshot.data ?? const <Award>[];
          if (awards.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const Center(child: Text('No awards found.')),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: awards.length,
              itemBuilder: (context, index) {
                final item = awards[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        item.isWinner
                            ? Icons.emoji_events_rounded
                            : Icons.workspace_premium_outlined,
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${item.issuer} • ${item.tier} (${item.date})',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '★ ${item.starCount}${item.isWinner ? ' • Winner' : ''}',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AwardDetailScreen(
                            award: item,
                            onDataChanged: _reload,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
