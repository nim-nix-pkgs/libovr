{
  description = ''Nim bindings for libOVR (Oculus Rift)'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."libovr-master".dir   = "master";
  inputs."libovr-master".owner = "nim-nix-pkgs";
  inputs."libovr-master".ref   = "master";
  inputs."libovr-master".repo  = "libovr";
  inputs."libovr-master".type  = "github";
  inputs."libovr-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."libovr-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}