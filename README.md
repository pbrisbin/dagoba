A Haskell port of http://www.aosabook.org/en/500L/dagoba-an-in-memory-graph-database.html.

*Work in progress*

## Roadmap

- [x] Data, interpreter, etc
- [x] Low-level in/out DSL
- [ ] High-level filter, map, aliases, etc
- [ ] Updates

## Notes

1. If I were better at Lens, it would probably make this much shorter. Alas.

1. The "Graph", once I was done implementing all the way to Example, only needed
   to be a map of `{ Id: Vertex a }` (where `a` is whatever data you care
   about). So I ripped out the Arrays and simplified the pointers from the
   JavaScript version. A lack of mutability actually forced me to this (IMO
   better) direction, FWIW.

1. The vertices can be traversed by their edges and those edge's `Id` pointers.
   And so a "Query" is just a monadic building up of results while traversing.
   Again, I feel Lens (well, Prisms) would fit really well here, but I don't
   know them.

1. All discussion of non-strict semantics and the related machinery is unneeded;
   the accumlated results are lazy so there's no need to implement all the
   pipetype or gremlin stuff to get the needed non-strict semantics.

1. I'm pretty sure layering in the filter, map, and alias stuff will be trivial,
   so I might not even do it:

   ```haskell
   -- Transformations
   mapQ = modify . map

   filterQ pred = modify $ filter pred

   -- Aliases
   parents = out

   grandParents = out >> out
   ```

1. I find the in/out terminology very confusing and error-prone, I wonder if the
   type system can help here. If you aren't careful, you can easily introduce a
   logic error without the type-checker noticing (because a result of following
   "in" vs "out" would still be the right type, even if it was the wrong
   direction).
