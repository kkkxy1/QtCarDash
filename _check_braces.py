with open(r"D:\C+project\QtInstrumentCluster\view\NormalMode.qml", "r", encoding="utf-8") as f:
    lines = f.readlines()

depth = 0
for i, line in enumerate(lines, 1):
    opens = line.count("{")
    closes = line.count("}")
    depth += opens - closes
    if depth < 0:
        print(f"Line {i}: NEGATIVE depth {depth} - EXTRA CLOSING BRACE!")
        print(f"  {line.rstrip()}")
    if opens > 0 or closes > 0:
        print(f"Line {i}: depth={depth-opens+closes} -> {depth}  {line.rstrip()}")

print(f"\nFinal depth: {depth}")