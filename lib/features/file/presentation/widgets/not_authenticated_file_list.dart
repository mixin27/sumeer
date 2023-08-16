import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sumeer/features/resume/feat_resume.dart';

class NoAuthenticatedFileList extends HookConsumerWidget {
  const NoAuthenticatedFileList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = useState<List<ResumeData>>([]);

    Future<void> getData() async {
      final result = await ref.read(resumeRepositoryProvider).getLocalData();
      data.value = result;
    }

    useEffect(() {
      getData();
      return null;
    }, []);

    return ListView.builder(
      itemBuilder: (context, index) {
        final resumeData = data.value[index];

        return ListTile(
          title: Text(
            resumeData.personalDetail?.fullName ?? "Unknown user",
          ),
          subtitle: Text(
            resumeData.personalDetail?.jobTitle ?? "Unknown job title",
          ),
          // trailing: IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.delete_outline,
          //     color: Theme.of(context).colorScheme.error,
          //   ),
          // ),
        );
      },
      itemCount: data.value.length,
    );
  }
}
