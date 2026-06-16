    // ref.listen<GoogleAuthState>(googleAuthProvider, (_, next) {
    //   next.when(
    //     initial: () {},
    //     loading: () {},
    //     success: (email) {
    //       ScaffoldMessenger.of(
    //         context,
    //       ).showSnackBar(
    //         SnackBar(content: Text('Logged in as $email')),
    //       );
    //       // Navigate to the main app screen after successful login
          
    //     },
    //     error: (message) {
    //       ScaffoldMessenger.of(
    //         context,
    //       ).showSnackBar(SnackBar(content: Text(message)));
    //     },
    //   );
    // });