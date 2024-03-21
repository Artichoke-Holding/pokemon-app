import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../models/user.dart';
import '../providers/providers.dart';
import '../viewmodels/user_view_model.dart';
import '../widgets/user_item.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = ref.read(usersViewModelProvider);
    if (viewModel.users.isEmpty) {
      viewModel.fetchUsers();
    }
  }
  void _handleLoadMore() {
    final viewModel = ref.read(usersViewModelProvider);
    if (viewModel.hasMore && !viewModel.isLoading) {
      viewModel.fetchUsers();
    }
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(usersViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title:  Text(FlutterI18n.translate(context, "users"),),
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Skeletonizer(
        enabled: viewModel.isLoading && viewModel.users.isEmpty,
        child: _buildUserList(viewModel),
      ),
    );
  }

  Widget _buildUserList(UsersViewModel viewModel) {
    final itemCount = viewModel.isLoading && viewModel.users.isEmpty
        ? 6
        : viewModel.hasMore
        ? viewModel.users.length + 1
        : viewModel.users.length;

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (viewModel.isLoading && viewModel.users.isEmpty) {
          return _buildUserSkeletonItem(); // Show skeleton item
        } else if (index >= viewModel.users.length) {
          // Handle load more case
          return viewModel.hasMore && viewModel.users.isNotEmpty
              ? const Center(child: CircularProgressIndicator())
              : const Center(child: Text("No more users"));
        }

        if (index == viewModel.users.length - 1 && viewModel.hasMore) {
          _handleLoadMore();
        }

        return UserListItem(user: viewModel.users[index]);
      },
    );
  }

  Widget _buildUserSkeletonItem() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            color: Colors.grey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.grey
                  ),
                  SizedBox(height: 5),
                  Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.grey
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
