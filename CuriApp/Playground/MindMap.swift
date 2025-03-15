////
////  MindMap.swift
////  CuriApp
////
////  Created by Hai Lam Nguyen on 12/3/25.
////
//
//import SwiftUI
//
///// MARK - Model
//struct Node: Identifiable, Equatable {
//    var id: UUID
//    var title: String
//    var position: CGPoint
//    var color: Color
//}
//
//struct Connection: Identifiable {
//    var id: UUID
//    var from: UUID
//    var to: UUID
//}
//
///// MARK - ViewModel
//class MindMapViewModel: ObservableObject {
//    @Published var nodes: [Node] = []
//    @Published var connections: [Connection] = []
//    
//    // For connection node
//    @Published var connectionMode: Bool = false
//    @Published var selectedNodeForConnection: [Node] = []
//    
//    func addNode(title: String, position: CGPoint, color: Color = Color.blue) {
//        let newNode = Node(id: UUID(), title: title, position: position, color: color)
//        nodes.append(newNode)
//    }
//    
//    func addConnection(from: UUID, to: UUID) {
//        // Prevent duplicate or self connection
//        guard from != to else { return }
//        if !connections.contains(where: { ($0.from == from && $0.to == to) || ($0.from == to && $0.to == from) }) {
//            let newConnection = Connection(id: UUID(), from: from, to: to)
//            connections.append(newConnection)
//        }
//    }
//    
//    func updateNode (_ node: Node) {
//        if let index = nodes.firstIndex(where: { $0.id == node.id }) {
//            nodes[index] = node
//        }
//    }
//}
//
//struct MindMap: View {
//    @ObservedObject var mindmapViewModel: MindMapViewModel
//    @Binding var isPresented: Bool
//    @Binding var newNodeTitle: String
//    @Binding var newNodeColor: Color
//    
//    @State var position: CGPoint = CGPoint(x: 200, y: 200)
//    
//    var body: some View {
//        VStack {
//            Text("Add New Node")
//                .font(.headline)
//            
//            TextField("Node Title", text: $newNodeTitle)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            //Color Picker
//            ColorPicker("Select Node Color", selection: $newNodeColor)
//                .padding(.horizontal)
//            
//            Button {
//                if !newNodeTitle.trimmingCharacters(in: .whitespaces).isEmpty {
//                    // For position, you might want to set it based on user interaction. Using a default.
//                    mindmapViewModel.addNode(title: newNodeTitle, position: position, color: newNodeColor)
//                    isPresented = false
//                    newNodeTitle = ""
//                    newNodeColor = .blue
//                }
//            } label: {
//                Text("Add Node")
//                    .foregroundStyle(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .cornerRadius(8)
//            }
//        }
//        .padding()
//        .navigationBarItems(leading:
//                                Button("Cancel") {
//            isPresented = false
//            newNodeTitle = ""
//            newNodeColor = .blue
//        })
//    }
//}
//
///// MARK - EditNodeView
//struct EditNodeView: View {
//    @ObservedObject var mindmapViewModel: MindMapViewModel
//    var node: Node
//    @Binding var isPresented: Bool
//    @Binding var editedTitle: String
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("Edit Node")
//                    .font(.headline)
//                
//                TextField("Node Title", text: $editedTitle)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                Button {
//                    var updatedNode = node
//                    updatedNode.title = editedTitle
//                    mindmapViewModel.updateNode(updatedNode)
//                    isPresented = false
//                } label: {
//                    Text("Save")
//                        .foregroundStyle(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.green)
//                        .cornerRadius(8)
//                }
//                .padding(.horizontal)
//                
//                Spacer()
//                    
//            }
//            .padding()
//            .navigationBarItems(leading:
//                                    Button("Cancel", action: {
//                isPresented = false
//            })
//            )
//        }
//    }
//}
//
///// MARK - NodeView
//struct NodeView: View {
//    @ObservedObject var mindmapViewModel: MindMapViewModel
//    @State var node: Node
//    @State private var isDragging = false
//    @State private var showingEdit = false
//    @State private var editedTitle: String = ""
//    @State private var showingColorPicker = false
//    
//    var body: some View {
//        Text(node.title)
//            .font(.headline)
//            .padding()
//            .background(node.color)
//            .foregroundStyle(.white)
//            .cornerRadius(8)
//            .position(node.position)
//            .overlay {
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(Color.yellow, lineWidth: 2)
//            }
//            .gesture(
//                DragGesture()
//                    .onChanged({ gesture in
//                        self.isDragging = true
//                        
//                        // Update position locally to reduce ViewModel updates during drag
//                        let newPosition = CGPoint(
//                            x: gesture.location.x,
//                            y: gesture.location.y
//                        )
//                        node.position = newPosition
//                        
//                        //Update node in ViewModel for connections to update
//                        mindmapViewModel.updateNode(node)
//                    })
//                    .onEnded({ _ in
//                        self.isDragging = false
//                    })
//            )
//            .onTapGesture(count: mindmapViewModel.connectionMode ? 1 : 2) {
//                if mindmapViewModel.connectionMode {
//                    mindmapViewModel.selectedNodeForConnection(node)
//                }
//            }
//    }
//    
//    func changeColor(to color: Color) {
//        node.color = color
//        mindmapViewModel.updateNode(node)
//    }
//}
//
////#Preview {
////    MindMap()
////}
