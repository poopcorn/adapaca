/* This is a SWIG interface file for generating interfaces to the Adpatagrams
 * libraries for languages other than C++.  It has currently been tested from
 * Java and Python, but could be adapted for other languages.
 */

/* File : adaptagrams.i */
%module(directors="1") adaptagrams

/* Allow target language to subclass and implement virtual methods for
 * these classes.
 */
%feature("director") Avoid::Router;
%feature("director") cola::TestConvergence;

#ifdef SWIGJAVA
/* Allow enum values to be logically ORed together as flags. */
%include "enumtypeunsafe.swg"
#endif

%{

#ifdef SWIGPYTHON
#define SWIG_FILE_WITH_INIT
#endif

#include <vector>
#include <libvpsc/variable.h>
#include <libvpsc/constraint.h>
#include <libvpsc/rectangle.h>
#include <libvpsc/assertions.h>
#include <libcola/cola.h>
#include <libcola/cluster.h>
#include <libcola/convex_hull.h>
#include <libcola/compound_constraints.h>
#include <libcola/shapepair.h>
#include <libcola/cc_nonoverlapconstraints.h>
#include <libcola/exceptions.h>
#include <libcola/aca3.h>
#include <libcola/stress_terms.h>
#include <libtopology/topology_graph.h>
#include <libtopology/cola_topology_addon.h>
#include <libavoid/libavoid.h>
#include <libtopology/orthogonal_topology.h>
/* Includes the header in the wrapper code */

using namespace Avoid;
using namespace cola;
using namespace hull;
using namespace vpsc;
using namespace topology;

%}

%ignore Avoid::XDIM;
%ignore Avoid::YDIM;
%ignore Avoid::Point::operator[];
%ignore cola::PreIteration::operator();
%ignore cola::PreIteration::locksNotUsed;
//%ignore cola::TestConvergence::operator();
%ignore operator<<(std::ostream &os, vpsc::Rectangle const &r);
%ignore vpsc::Rectangle::setXBorder(double);
%ignore vpsc::Rectangle::setYBorder(double);
%ignore vpsc::assertNoOverlaps(const Rectangles& rs);
%ignore Avoid::Point::operator==(const Point&) const;
%ignore Avoid::Point::operator!=(const Point&) const;
%ignore Avoid::Point::operator<(const Point&) const;
%ignore Avoid::Point::operator-(const Point&) const;
%ignore Avoid::Point::operator+(const Point&) const;
%ignore Avoid::ShapeConnectionPin::operator<(const ShapeConnectionPin& rhs) const;
%ignore Avoid::ShapeConnectionPin::operator==(const ShapeConnectionPin& rhs) const;
%ignore Avoid::CmpConnPinPtr::operator()(const ShapeConnectionPin *lhs, const ShapeConnectionPin *rhs) const;
%ignore cola::SubConstraint;
%ignore cola::SubConstraintAlternatives;
%ignore cola::SubConstraintInfo;
%ignore std::vector<cola::SubConstraintInfo>;
%ignore cola::Resize::Resize();
%ignore vpsc::Constraint::Constraint();
%ignore topology::Segment;
%ignore topology::EdgePoint::inSegment;
%ignore topology::EdgePoint::outSegment;
%ignore topology::EdgePoint::bendConstraint;
%ignore topology::EdgePoint::prune();
%ignore topology::EdgePoint::getBendConstraint(std::vector<TopologyConstraint*>* ts);
%ignore topology::EdgePoint::createBendConstraint();
%ignore topology::EdgePoint::deleteBendConstraint();
%ignore topology::Edge::firstSegment;
%ignore topology::Edge::lastSegment;
%ignore topology::Edge::getTopologyConstraints(std::vector<TopologyConstraint*>* ts) const;
%ignore topology::Edge::getRoute() const;
%ignore topology::Edge::toString() const;
%ignore topology::Edge::toString() const;
%ignore topology::assertConvexBends(const Edges&);
%ignore topology::assertNoSegmentRectIntersection(const Nodes&, const Edges&);
%ignore topology::assertNoZeroLengthEdgeSegments(const Edges& es);
%ignore topology::compute_stress(const Edges&);
%ignore topology::printEdges(const Edges&);

%include "std_string.i"
%include "std_vector.i"
%include "std_pair.i"

#ifdef SWIGJAVA
/* Wrap every C++ action in try/catch statement so we convert all 
 * possible C++ exceptions (generated from C++ assertion failures)
 * into Java exceptions.
 */
%exception {
    try {
        $action
    } catch(vpsc::CriticalFailure cf) {
        jclass excep = jenv->FindClass("org/adaptagrams/ColaException");
        if (excep)
            jenv->ThrowNew(excep, cf.what().c_str());
    } catch(cola::InvalidVariableIndexException ivi) {
        jclass excep = jenv->FindClass("org/adaptagrams/ColaException");
        if (excep)
            jenv->ThrowNew(excep, ivi.what().c_str());
    } 
}

/* Define a Java ColaException class.
 */
%typemap(javabase) cola::ColaException "java.lang.Exception";
%inline %{
namespace cola {
class ColaException {
    public:
        ColaException(const std::string& msg) : message(msg) {}
        std::string getMessage() {
            return message;
        }
    private:
      std::string message;
};
}
%}
#endif

/* We have a problem where in garbage collected languages like Java and Python,
 * objects that appear to no longer be used and go out of scope can cause 
 * their corresponding internal C++ instances to be freed prematurely.  
 * For this reason we generate empty finialise methods for the following 
 * classes and clean them up later.
 *
 * For libavoid, the Router instance takes ownership of these objects and 
 * deletes them when it is freed.  For the cola/vpsc classes, a Java/Python
 * user can call ConstraintedFDLayout::freeAssociatedObjects() to free this 
 * memory.
 */
%nodefaultdtor vpsc::Rectangle;
%nodefaultdtor cola::CompoundConstraint;
%nodefaultdtor cola::AlignmentConstraint;
%nodefaultdtor cola::BoundaryConstraint;
%nodefaultdtor cola::DistributionConstraint;
%nodefaultdtor cola::MultiSeparationConstraint;
%nodefaultdtor cola::PageBoundaryConstraints;
%nodefaultdtor cola::SeparationConstraint;
%nodefaultdtor cola::OrthogonalEdgeConstraint;
%nodefaultdtor cola::FixedRelativeConstraint;
%nodefaultdtor cola::NonOverlapConstraints;
%nodefaultdtor cola::Cluster;
%nodefaultdtor cola::RootCluster;
%nodefaultdtor cola::ConvexCluster;
%nodefaultdtor cola::RectangularCluster;
%nodefaultdtor cola::ACALayout3;
%nodefaultdtor Avoid::ShapeRef;
%nodefaultdtor Avoid::ConnRef;
%nodefaultdtor Avoid::ClusterRef;
%nodefaultdtor Avoid::JunctionRef;
%nodefaultdtor Avoid::Obstacle;
%nodefaultdtor Avoid::ShapeConnectionPin;
%nodefaultdtor cola::PreIteration;
%nodefaultdtor cola::TestConvergence;
%nodefaultdtor cola::Lock;
%nodefaultdtor cola::Resize;
%nodefaultdtor topology::Node;
%nodefaultdtor topology::Edge;
%nodefaultdtor topology::EdgePoint;
%nodefaultdtor topology::ColaTopologyAddon;

%template(Chars) std::vector<char>;
%template(Unsigneds) std::vector<unsigned>;
%template(Doubles) std::vector<double>;

%template(UnsatisfiableConstraintInfoPtrs) std::vector<cola::UnsatisfiableConstraintInfo *>;
%template(ColaEdge) std::pair<unsigned,unsigned>;
%template(ColaEdges) std::vector< std::pair<unsigned,unsigned> >;
%template(VariablePtrs) std::vector<vpsc::Variable*>;
%template(ConstraintPtrs) std::vector<vpsc::Constraint*>;
%template(RectanglePtrs) std::vector<vpsc::Rectangle*>;
%template(CompoundConstraintPtrs) std::vector<cola::CompoundConstraint*>;
%template(StressTermPtrs) std::vector<cola::StressTerm*>;
%template(OrderedAlignmentPtrs) std::vector<cola::OrderedAlignment*>;
%template(ColaLocks) std::vector<cola::Lock>;
%template(ColaResizes) std::vector<cola::Resize>;
%template(ColaDesiredPositions) std::vector<cola::DesiredPosition>;
%template(TopologyEdgePointPtrs) std::vector<topology::EdgePoint*>;
%template(TopologyEdgePointConstPtrs) std::vector<const topology::EdgePoint*>;
%template(TopologyEdgePtrs) std::vector<topology::Edge*>;
%template(TopologyNodePtrs) std::vector<topology::Node*>;
%template(ColaClusters) std::vector<cola::Cluster*>;
%template(AvoidPoints) std::vector<Avoid::Point>;
%template(AvoidCheckpoints) std::vector<Avoid::Checkpoint>;

%inline %{
void doubleArraySet(double *a, int i, double val) {
   a[i] = val;
}
double doubleArrayGet(const double *a, int i) {
   return a[i];
}
double *newDoubleArray(int size) {
   return new double[size];
}
void deleteDoubleArray(double* a) {
   delete a;
}
%}

%rename(ColaTestConvergenceOperator) cola::TestConvergence::operator();

%rename(AvoidBox) Avoid::Box;
%rename(AvoidEdge) Avoid::Edge;
%rename(AvoidRectangle) Avoid::Rectangle;
%rename(AvoidTopologyAddonInterface) Avoid::TopologyAddonInterface;

%rename(getVarConst) topology::Node::getVar() const;


/* Parse the header file to generate wrappers */
%include "libvpsc/rectangle.h"
%include "libvpsc/assertions.h"
%include "libvpsc/variable.h"
%include "libvpsc/constraint.h"

%include "libcola/compound_constraints.h"
%include "libcola/shapepair.h"
%include "libcola/cc_nonoverlapconstraints.h"
%include "libcola/cola.h"
%include "libcola/cluster.h"
%include "libcola/convex_hull.h"
%include "libcola/exceptions.h"
%include "libcola/aca3.h"
%include "libcola/stress_terms.h"

%include "libavoid/dllexport.h"
%include "libavoid/geometry.h"
%include "libavoid/geomtypes.h"
%include "libavoid/connend.h"
%include "libavoid/router.h"
%include "libavoid/connector.h"
%include "libavoid/obstacle.h"
%include "libavoid/shape.h"
%include "libavoid/junction.h"
%include "libavoid/viscluster.h"
%include "libavoid/connectionpin.h"

%include "libtopology/topology_graph.h"
%include "libtopology/cola_topology_addon.h"
%include "libtopology/orthogonal_topology.h"


