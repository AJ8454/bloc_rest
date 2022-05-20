import 'package:bloc_rest/bloc/home_bloc/home_bloc.dart';
import 'package:bloc_rest/services/connectivity_services.dart';
import 'package:bloc_rest/services/knowello_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Post>? posts;
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<KnowelloService>(context),
        RepositoryProvider.of<ConnectivityServices>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('knowelloGram'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              posts = state.props.cast<Post>();
              return ListView.builder(
                itemCount: posts!.length,
                itemBuilder: (context, index) {
                  return Text('${posts![index].profileImage}');
                },
              );
            }
            if (state is HomeNoInternetState) {
              return const Center(
                child: Text('No Internet!!'),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
