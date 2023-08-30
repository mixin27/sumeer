import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sumeer/features/data_input/presentation/widget/add_certificate_form.dart';
import 'package:sumeer/utils/utils.dart';
import '../../../../features.dart';

class CertificateWidget extends StatefulHookConsumerWidget {
  const CertificateWidget({super.key});

  @override
  ConsumerState<CertificateWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends ConsumerState<CertificateWidget> {
  @override
  Widget build(BuildContext context) {
    final certificate = ref.watch(resumeDataProvider)?.certificate;
    final certificateList = certificate?.certificates ?? [];
    wLog(certificateList);
    return Column(
      children: List.generate(
        certificateList.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (cxt) {
                    return AddCertificateForm(certificateList[index], index);
                  });
            },
            title: Text(certificateList[index].title ?? ''),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(certificateList[index].description ?? ''),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                final oldResumeDataProvider = ref.watch(resumeDataProvider);

                List<Certificate> newCertificateList = [];

                for (var element in certificateList) {
                  newCertificateList.add(element);
                }
                newCertificateList.removeAt(index);

                CertificateSection certificateSection = CertificateSection(
                  title: '',
                  certificates: newCertificateList,
                );
                final newResumeData = oldResumeDataProvider?.copyWith(
                  certificate: certificateSection,
                );
                setState(() {
                  ref
                      .read(resumeDataProvider.notifier)
                      .update((state) => newResumeData);
                });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
