import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListview> createState() => _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if(widget.loadNextPage == null) return;

      if((scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent){
        
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
            const SizedBox(height: 10,),
          Expanded(
            // Cuando no tenemos un número definido de elementos utilizamos .builder
            // Utilizando un ListView se almacena todo en memoria.
            child: ListView.builder(
              controller: scrollController,
              // Casi siempre utilizaremos .builder
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* IMAGEN
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  return GestureDetector(
                    onTap: () => context.push('/home/0/movie/${movie.id}'), // Para que podamos volver utilizamos .push
                    child: FadeIn(child: child),

                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 5,),

          //* Title
          Expanded(
            child: SizedBox(
              width: 150,
              child: Text(
                movie.title,
                maxLines: 2,
                style: textStyles.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          //* RATING
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800,),
                const SizedBox(width: 3,),
                Text('${movie.voteAverage}', style: textStyles.bodyMedium?.copyWith(color: Colors.yellow.shade800),),
                const SizedBox(width: 20,),
                Text(HumanFormat.number(movie.popularity), style: textStyles.bodySmall,),
                // Text('${movie.popularity}', style: textStyles.bodySmall,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!))
        ],
      ),
    );
  }
}
